//
//  CatalogPresenter.swift
//  GBShop
//
//  Created by Admin on 5/20/19.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation
import UIKit

//Протокол Пресентера для окна списка товаров
protocol CatalogPresenter {
    
    //Указание наличия роутера для переходов из окна списка товаров
    var router: CatalogRouter { get }
    //Указание наличия переменной, отражающей количество строк в списке
    var rowsCount: Int { get }
    
    //Указание инициализации пресентера
    init (view: CatalogView, model: CatalogModel, router: CatalogRouter)
    //Функция для получения списка товаров
    func getCatalogRows()
    //Функция для обновления списка товаров
    func refreshCatalogRows()
    //Функция для конфигурации ячейки списка товаров
    func configure(cell: CatalogCellView, forRow row: Int)
    //Функция для получения списка товаров по введенному Пользователем тексту
    func changeSearchText(_ text: String)
    //Функция для перехода в окно Корзина
    func showBasket()
    ///Функция, вызываемая при выборе Пользователем товара
    func selectRow(row: Int)
}

class CatalogPresenterImplementation: CatalogPresenter {
    
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
    
    public func selectRow(row: Int) {
        router.showProductInfoScene(product: model.getProduct(by: row))
    }
    
    //MARK: - Закрытые функции
    //В данной функции происходит попытка получения
    //списка товаров и при успешной попытке
    //данные отображаются или выводится ошибка
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
                DispatchQueue.main.async {
                    if let view = self.view {
                        view.refreshCatalogView()
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
    
    private func changeLoad(isLoad: Bool) {
        self.isLoad = isLoad
        if let view = view {
            isLoad ? view.startLoading() : view.finishLoading()
        }
    }
    
}

