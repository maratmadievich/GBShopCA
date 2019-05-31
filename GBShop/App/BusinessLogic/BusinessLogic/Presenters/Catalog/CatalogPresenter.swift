//
//  CatalogPresenter.swift
//  GBShop
//
//  Created by Admin on 5/20/19.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation
import UIKit

/// Описывает Пресентер для окна списка товаров
internal protocol CatalogPresenter {
    
    /// Указывает наличие роутера для переходов из окна списка товаров
    var router: CatalogRouter { get }
    
    /// Указывает количество товаров
    var rowsCount: Int { get }
    
    /// Описание необходимой инициализации
    /// Параметры:
    /// - view: объект, имеющий расширение CatalogView для реализации модели MVP
    /// - model: модель для реализации модели MVP
    /// - router: объект, имеющий расширение CatalogRouter для реализации переходов
    init (view: CatalogView, model: CatalogModel, router: CatalogRouter)
    
    /// Вызывает загрузку списка товаров
    func getCatalogRows()
    
    /// Осуществляет обновление списка товаров
    func refreshCatalogRows()
    
    /// Осуществляет конфигурацию ячейки товара
    /// Параметры:
    /// - cell: отображаемая ячейка
    /// - row: порядковый ячейки
    func configure(cell: CatalogCellView, forRow row: Int)
    
    /// Осуществляет фильтрацию списка товаров согласно
    /// введенному пользователем текста
    /// Параметры:
    /// - text: введенный пользователем текст
    func changeSearchText(_ text: String)
    
    /// Осуществляет переход к окну Корзина
    func showBasket()
    
    /// Осуществляет переход к окну Информация о товаре
    func showProductInfo(row: Int)
}

internal class CatalogPresenterImplementation: CatalogPresenter {
    
    fileprivate weak var view: CatalogView?
    private var model: CatalogModel
    internal var router: CatalogRouter
    
    public var rowsCount: Int {
        return model.getProductsCount()
    }
    
    private var isLoad: Bool = false
    private let requestFactory = RequestFactory()
    
    
    //MARK: - Публичные функции
    required init(view: CatalogView, model: CatalogModel, router: CatalogRouter) {
        self.view = view
        self.model = model
        self.router = router
    }
    
    //В данной функции устанавливаются дефолтные параметры,
    //обновляется окно списка продуктов и
    //вызывается функция получения списка товаров
    public func refreshCatalogRows() {
        model.pageNumber = 0
        model.maxRowsCount = 1000
        model.isSearchable = false
        
        model.products.removeAll()
        model.searchProducts.removeAll()
        if let view = view {
            view.refreshCatalogView()
        }
        getCatalogRows()
    }
    
    //Проверяются данные и
    //вызывается API-метод получения списка товаров
    public func getCatalogRows() {
        if !isLoad && !model.isSearchable && model.maxRowsCount > model.products.count {
            callGetCatalogRequest()
        }
    }
    
    public func configure(cell: CatalogCellView, forRow row: Int) {
        let product = model.getProduct(by: row)
        cell.setName(text: product.name)
        cell.setPrice(text: String(product.price))
    }
    
    //Проверяется текст, введенный пользователем
    //и в зависимости от его наличия отображаются товары,
    //в названии которых есть поисковое слово или все товары
    public func changeSearchText(_ text: String) {
        let trimmingSearchText = text.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        model.isSearchable = trimmingSearchText.count > 0
        
        if model.isSearchable {
            model.searchProducts = model.products.filter{ $0.name.lowercased().contains(trimmingSearchText) }
        }
        if let view = view {
            view.refreshCatalogView()
        }
    }
    
    public func showBasket() {
        router.showBasketScene()
    }
    
    public func showProductInfo(row: Int) {
        router.showProductInfoScene(product: model.getProduct(by: row))
    }
    
    //MARK: - Закрытые функции
    
    private func callGetCatalogRequest() {
        changeLoad(isLoad: true)
        
        let catalogRequest = requestFactory.makeCatalogDataRequestFatory()
        catalogRequest.getCatalogData(pageNumber: model.pageNumber, idCategory: model.idCategory) {
            [unowned self] response in
            
            self.changeLoad(isLoad: false)
            switch response.result {
            case .success(let catalogResponse):
                self.model.products.append(contentsOf: catalogResponse.products)
                self.model.pageNumber += 1
                self.model.maxRowsCount = catalogResponse.maxRowsCount
                self.handleGetCatalogSuccess()
                
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
    
    /// Вызывает метод для обновления списка товаров
    private func handleGetCatalogSuccess() {
        Analytic.instance.sendEvent(method: .catalog, parameters: nil)
        if let view = view {
            DispatchQueue.main.async {
                view.refreshCatalogView()
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

