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
        
        model.products.removeAll()
        
        view?.refreshCatalogView()
        
        getCatalogRows()
    }
    
    
    func getCatalogRows() {
        
        if !isLoad && model.maxRowsCount > model.products.count {
            
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
        
        return model.products.count
    }
    
    
    func configure(cell: CatalogCellView, forRow row: Int) {
        
        cell.setName(text: model.products[row].name)
        
        cell.setPrice(text: String(model.products[row].price))
    }
   
    
    func showProfile() {
        
        let storyboard = UIStoryboard(name: "Profile", bundle: nil)
        
        let viewController = storyboard.instantiateViewController(withIdentifier: "Profile") as! ProfileViewController
        
        view?.showView(viewController: viewController)
    }
    
    
}

