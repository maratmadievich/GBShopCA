//
//  CatalogPresenter.swift
//  GBShop
//
//  Created by Admin on 5/20/19.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation
import UIKit

class CatalogPresenter: CatalogPresenterProtocol {
    
    weak fileprivate var view: CatalogView?
    
    private var model: CatalogModel!
    
    private var isLoad: Bool = false
    
    private let requestFactory = RequestFactory()
    
    
    required init(view: CatalogView) {
        
        self.view = view
        
        model = CatalogModel()
    }
    
    
    func refreshCatalogRows() {
        
        model.pageNumber = 0
        
        model.maxRowsCount = 1000
        
        model.isSearchable = false
        
        model.products.removeAll()
        
        model.searchProducts.removeAll()
        
        view?.refreshCatalogView()
        
        getCatalogRows()
    }
    
    
    func getCatalogRows() {
        
        if !isLoad && !model.isSearchable && model.maxRowsCount > model.products.count {
            
            callGetCatalogRequest()
        }
        
    }
    
    
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
    
    
    func getRowsCount() -> Int {
        
        return model.isSearchable ? model.searchProducts.count : model.products.count
    }
    
    
    func configure(cell: CatalogCellView, forRow row: Int) {
        
        let product = model.isSearchable ? model.searchProducts[row] : model.products[row]
        
        cell.setName(text: product.name)
        
        cell.setPrice(text: String(product.price))
    }
    
    
    func changeSearchText(_ text: String) {
        
        let trimmingSearchText = text.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        
        model.isSearchable = trimmingSearchText.count > 0
        
        if model.isSearchable {
            
            model.searchProducts = model.products.filter{ $0.name.lowercased().contains(trimmingSearchText) }
        }
            
        view?.refreshCatalogView()
    }
   
    
    func showProfile() {
        
        let storyboard = UIStoryboard(name: "Profile", bundle: nil)
        
        let viewController = storyboard.instantiateViewController(withIdentifier: "Profile") as! ProfileViewController
        
        view?.showView(viewController: viewController)
    }
    
    
}

