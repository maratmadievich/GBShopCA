//
//  BasketPresenter.swift
//  GBShop
//
//  Created by Admin on 5/28/19.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation

//Протокол Пресентера для окна корзины
protocol BasketPresenter {
    
    //Указание наличия роутера для переходов из окна корзины
    var router: BasketRouter { get }
    //Указание наличия переменной, отражающей количество строк в списке
    var rowsCount: Int { get }
    
    //Указание инициализации пресентера
    init (view: BasketView, model: BasketModel, router: BasketRouter)
    //Функция, вызываемая в момент, когда окно загрузится
    func viewDidLoad()
    //Функция для конфигурации ячейки списка товаров в корзине
    func configure(cell: BasketCellView, forRow row: Int)
    //Функция оплаты товаров в корзине
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
    
    //MARK: - Публичные функции
    required init(view: BasketView, model: BasketModel, router: BasketRouter) {
        self.view = view
        self.model = model
        self.router = router
    }
    
    //Здесь вызывается API-метод по получению списка товаров в корзине
    public func viewDidLoad() {
        callGetBasketRequest()
    }
    
    public func configure(cell: BasketCellView, forRow row: Int) {
        let productFromBasket = model.products[row]
        cell.setProductName(text: productFromBasket.name)
        cell.setProductCount(text: "Количество: \(productFromBasket.quantity)")
        cell.setProductPrice(text: "Цена: \(productFromBasket.quantity * productFromBasket.price)р")
    }
    
    //Здесь вызывается API-метод по оплате товаров
    func buyProducts() {
        callPaymentRequest()
    }
    
    //MARK: - Закрытые функции
    //В данной функции происходит попытка получения
    //списка товаров и при успешной попытке
    //данные отображаются или выводится ошибка
    private func callGetBasketRequest() {
        changeLoad(isLoad: true)
        
        let getBasketRequest = requestFactory.makeGetBasketRequestFatory()
        getBasketRequest.getBasket(idUser: UserSingleton.instance.getUser().id) {
            [unowned self] response in
            
            self.changeLoad(isLoad: false)
            switch response.result {
            case .success(let getBasketResponse):
                self.model.products.append(contentsOf: getBasketResponse.products)
                self.model.amount = getBasketResponse.amount
                self.handleGetBasketSuccess()
                
            case .failure(let error):
                self.handleError(error: error.localizedDescription)
            }
        }
    }
    
    //В данной функции происходит попытка оплаты и
    //при успешной попытке выводится уведомление об оплате
    //или выводится ошибка
    private func callPaymentRequest() {
        changeLoad(isLoad: true)
        
        let paymentRequest = requestFactory.makePaymentRequestFatory()
        paymentRequest.payment() {
            [unowned self] response in
            
            self.changeLoad(isLoad: false)
            switch response.result {
            case .success(let paymentResponse):
                self.handlePaymentSuccess(message: paymentResponse.message)
                
            case .failure(let error):
                self.handleError(error: error.localizedDescription)
            }
        }
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
    
    /// Вызывает метод для отображения информации о товарах
    /// в корзине и их общей стоимости
    private func handleGetBasketSuccess() {
        Analytic.instance.sendEvent(method: .basket, parameters: nil)
        if let view = self.view {
            DispatchQueue.main.async {
                view.setTotalAmout(text: "Купить (\(self.model.amount)р)")
                view.refreshProducts()
            }
        }
    }
    
    /// Отображает информацию об успешной оплате товаров
    private func handlePaymentSuccess(message: String) {
        Analytic.instance.sendEvent(method: .payment, parameters: nil)
        if let view = self.view {
            DispatchQueue.main.async {
                view.showSuccess(title: self.messagePaymentTitle, text: message)
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
