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
            guard let view = view else {
                return
            }
            view.showError(text: messageIncorrectCount)
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
                DispatchQueue.main.async {
                    if let view = self.view {
                        view.refreshReviews()
                    }
                }
               
            case .failure(let error):
                DispatchQueue.main.async {
                    if let view = self.view {
                        view.showError(text: error.localizedDescription)
                    }
                }
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
                DispatchQueue.main.async {
                    if let view = self.view {
                        view.showSuccess(title: self.messageAddToBasketTitle, text: self.messageAddToBasketText)
                    }
                }
                
            case .failure(let error):
                DispatchQueue.main.async {
                    if let view = self.view {
                        view.showError(text: error.localizedDescription)
                    }
                }
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
    
    private func changeLoad(isLoad: Bool) {
        self.isLoad = isLoad
        if let view = view {
            isLoad ? view.startLoading() : view.finishLoading()
        }
        
    }
    
}


