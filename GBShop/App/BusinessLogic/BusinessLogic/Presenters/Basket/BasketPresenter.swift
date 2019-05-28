//
//  BasketPresenter.swift
//  GBShop
//
//  Created by Admin on 5/28/19.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation

protocol BasketPresenter {
    
    var router: BasketRouter { get }
    var rowsCount: Int { get }
    
    init (view: BasketView, model: BasketModel, router: BasketRouter)
    
    func viewDidLoad()
    func configure(cell: BasketCellView, forRow row: Int)
    func buyProducts()
}

class BasketPresenterImplementation: BasketPresenter {
    
    fileprivate weak var view: BasketView?
    private var model: BasketModel
    internal var router: BasketRouter
    
    private var isLoad: Bool = false
    private let requestFactory = RequestFactory()
    private let messagePaymentTitle = "Покупка товаров"
    
    public var rowsCount: Int {
        return model.products.count
    }
    
    
    required init(view: BasketView, model: BasketModel, router: BasketRouter) {
        self.view = view
        self.model = model
        self.router = router
    }
    
    //MARK: - Публичные функции
    public func viewDidLoad() {
        callGetBasketRequest()
    }
    
    public func configure(cell: BasketCellView, forRow row: Int) {
        let productFromBasket = model.products[row]
        cell.setProductName(text: productFromBasket.name)
        cell.setProductCount(text: "Количество: \(productFromBasket.quantity)")
        cell.setProductPrice(text: "Цена: \(productFromBasket.quantity * productFromBasket.price)р")
    }
    
    func buyProducts() {
        callPaymentRequest()
    }
    
    //MARK: - Закрытые функции
    private func callGetBasketRequest() {
        changeLoad(isLoad: true)
        
        let getBasketRequest = requestFactory.makeGetBasketRequestFatory()
        getBasketRequest.getBasket(idUser: UserSingleton.instance.getUser().id) {
            [unowned self] response in
            
            DispatchQueue.main.async {
                self.changeLoad(isLoad: false)
                switch response.result {
                case .success(let getBasketResponse):
                    self.model.products.append(contentsOf: getBasketResponse.products)
                    self.model.amount = getBasketResponse.amount
                    if let view = self.view {
                        view.setTotalAmout(text: "Купить (\(self.model.amount)р)")
                        view.refreshProducts()
                    }
                    
                case .failure(let error):
                    if let view = self.view {
                        view.showError(text: error.localizedDescription)
                    }
                }
            }
        }
    }
    
    func callPaymentRequest() {
        changeLoad(isLoad: true)
        
        let paymentRequest = requestFactory.makePaymentRequestFatory()
        paymentRequest.payment() {
            [unowned self] response in
            
            DispatchQueue.main.async {
                self.changeLoad(isLoad: false)
                switch response.result {
                case .success(let paymentResponse):
                    if let view = self.view {
                        view.showSuccess(title: self.messagePaymentTitle, text: paymentResponse.message)
                    }
                    
                case .failure(let error):
                    if let view = self.view {
                        view.showError(text: error.localizedDescription)
                    }
                }
            }
        }
    }

    
    private func changeLoad(isLoad: Bool) {
        self.isLoad = isLoad
        if let view = view {
            isLoad ? view.startLoading() : view.finishLoading()
        }
    }
    
}
