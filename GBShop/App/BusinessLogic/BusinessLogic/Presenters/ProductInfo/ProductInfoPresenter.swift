//
//  ProductInfoPresenter.swift
//  GBShop
//
//  Created by Марат Нургалиев on 27/05/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation

protocol ProductInfoPresenter {
    
    var router: ProductInfoRouter { get }
    var rowsCount: Int { get }
    
    init (view: ProductInfoView, model: ProductInfoModel, router: ProductInfoRouter)
    
    func viewDidLoad()
    func getReviewRows()
    func addToBasket(quantityString: String)
    func configure(cell: ProductInfoCellView, forRow row: Int)
}

class ProductInfoPresenterImplementation: ProductInfoPresenter {
 
    fileprivate weak var view: ProductInfoView?
    private var model: ProductInfoModel
    internal var router: ProductInfoRouter
    
    private var isLoad: Bool = false
    private let requestFactory = RequestFactory()
    private let messageIncorrectCount = "Вы указали некорректное количество!"
    private let messageAddToBasketTitle = "Добавление в корзину"
    private let messageAddToBasketText = "Добавление прошло успешно!"
    
    public var rowsCount: Int {
        return model.reviews.count
    }
    
    
    required init(view: ProductInfoView, model: ProductInfoModel, router: ProductInfoRouter) {
        self.view = view
        self.model = model
        self.router = router
    }
    
    //MARK: - Публичные функции
    public func viewDidLoad() {
        showProductData()
        callGetReviewsRequest()
    }
    
    public func getReviewRows() {
        if !isLoad && model.maxReviewsCount > model.reviews.count {
            callGetReviewsRequest()
        }
    }
    
    public func addToBasket(quantityString: String) {
        let quantity = Int(quantityString) ?? 0
        if quantity > 0 {
            callAddToBasketRequest(quantity: quantity)
        } else {
            handleError(error: messageIncorrectCount)
        }
        
    }
    
    public func configure(cell: ProductInfoCellView, forRow row: Int) {
        let review = model.reviews[row]
        cell.setUserName(text: review.userName)
        cell.setReview(text: review.text)
    }
    
    //MARK: - Закрытые функции
    private func callGetReviewsRequest() {
        changeLoad(isLoad: true)
        
        let getReviewsRequest = requestFactory.makeGetReviewsRequestFatory()
        getReviewsRequest.getReviews(idProduct: model.product.id, pageNumber: model.pageNumber) {
            [unowned self] response in
            
            self.changeLoad(isLoad: false)
            switch response.result {
            case .success(let getReviewsResponse):
                self.model.reviews.append(contentsOf: getReviewsResponse.reviews)
                self.model.pageNumber += 1
                self.model.maxReviewsCount = getReviewsResponse.maxRowsCount
                self.handleGetReviewsSuccess()
               
            case .failure(let error):
                self.handleError(error: error.localizedDescription)
            }
        }
    }
    
    private func callAddToBasketRequest(quantity: Int) {
        changeLoad(isLoad: true)
        
        let addToBasketRequest = requestFactory.makeAddToBasketRequestFatory()
        addToBasketRequest.addToBasket(idProduct: model.product.id, quantity: quantity) {
            [unowned self] response in
            
            self.changeLoad(isLoad: false)
            switch response.result {
            case .success(_):
                self.handleAddToBasketSuccess()
                
            case .failure(let error):
                self.handleError(error: error.localizedDescription)
            }
        }
    }
    
    private func showProductData() {
        guard let view = view else {
            return
        }
        view.setProductName(text: model.product.name)
        view.setProductPrice(text: "Цена: \(model.product.price)р")
    }
    
    /// Меняет состояние загрузки данных на экране
    private func changeLoad(isLoad: Bool) {
        self.isLoad = isLoad
        if let view = view {
            DispatchQueue.main.async {
                isLoad ? view.startLoading() : view.finishLoading()
            }
        }
    }
    
    /// Отображает коментарии к товару
    private func handleGetReviewsSuccess() {
        Analytic.instance.sendEvent(method: .reviews, parameters: nil)
        if let view = view {
            DispatchQueue.main.async {
                view.refreshReviews()
            }
        }
    }
    
    /// Вызывает метод для перехода к экрану Списка товаров
    private func handleAddToBasketSuccess() {
        Analytic.instance.sendEvent(method: .addToBasket, parameters: ["product": model.product.name])
        if let view = view {
            DispatchQueue.main.async {
                view.showSuccess(title: self.messageAddToBasketTitle, text: self.messageAddToBasketText)
            }
        }
    }
    
    /// Отображает ошибки на экране
    private func handleError(error: String) {
        Analytic.instance.assertionFailure(method: .login, message: error)
        if let view = view {
            DispatchQueue.main.async {
                view.showError(text: error)
            }
        }
    }
    
}


