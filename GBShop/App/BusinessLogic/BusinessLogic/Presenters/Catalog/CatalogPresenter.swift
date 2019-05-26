//
//  CatalogPresenter.swift
//  GBShop
//
//  Created by Admin on 5/20/19.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation
import UIKit

protocol CatalogPresenter {
    
    var rowsCount: Int { get }
    var router: CatalogRouter { get }
    
    init (view: CatalogView, model: CatalogModel, router: CatalogRouter)
    func getCatalogRows()
    func refreshCatalogRows()
    func configure(cell: CatalogCellView, forRow row: Int)
    func changeSearchText(_ text: String)
    func showProfile()
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
    
    
    required init(view: CatalogView, model: CatalogModel, router: CatalogRouter) {
        self.view = view
        self.model = model
        self.router = router
    }
    
    //MARK: - Публичные функции
    public func refreshCatalogRows() {
        model.pageNumber = 0
        model.maxRowsCount = 1000
        model.isSearchable = false
        
        model.products.removeAll()
        model.searchProducts.removeAll()
        view?.refreshCatalogView()
        getCatalogRows()
    }
    
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
    
    public func changeSearchText(_ text: String) {
        let trimmingSearchText = text.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        model.isSearchable = trimmingSearchText.count > 0
        
        if model.isSearchable {
            model.searchProducts = model.products.filter{ $0.name.lowercased().contains(trimmingSearchText) }
        }
        view?.refreshCatalogView()
    }
    
    public func showProfile() {
        router.showProfileScene()
    }
    
    public func selectRow(row: Int) {
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
                DispatchQueue.main.async { self.view?.refreshCatalogView() }
                
            case .failure(let error):
                DispatchQueue.main.async { self.view?.showError(text: error.localizedDescription) }
            }
        }
    }
    
    private func changeLoad(isLoad: Bool) {
        self.isLoad = isLoad
        isLoad ? view?.startLoading() : view?.finishLoading()
    }
    
}

