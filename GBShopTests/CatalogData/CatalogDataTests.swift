//
//  CatalogDataTests.swift
//  GBShopTests
//
//  Created by Марат Нургалиев on 26/04/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import XCTest
import Alamofire
@testable import GBShop

class CatalogDataTests: XCTestCase {
    
    let expectation = XCTestExpectation(description: "Тестирование метода получения товаров")
    
    var requestFactory: RequestFactory!
    
    var pageNumber: Int!
    
    var idCategory: Int!
    
    
    override func setUp() {
        
        requestFactory = RequestFactory()
        
        pageNumber = 1
        
        idCategory = 1
    }
    
    
    override func tearDown() {
        
        requestFactory = nil
        
        pageNumber = nil
        
        idCategory = nil
    }
    
    
    func testGetCatalogData() {
        
        let catalogData = requestFactory.makeCatalogDataRequestFatory()
        
        catalogData.getCatalogData(pageNumber: pageNumber, idCategory: idCategory) { response in
            
            switch response.result {
                
            case .success(let catalog):
                
                self.checkCatalogDataResult(catalog)
                
                break
                
            case .failure(let error):
                
                XCTFail("CatalogDataTests: \(error.localizedDescription)")
            }
            
            self.expectation.fulfill()
            
        }
        
        wait(for: [expectation], timeout: 10.0)
        
    }
    
    
    private func checkCatalogDataResult(_ catalog: CatalogDataResult) {
        
        if catalog.pageNumber < 0 {
            
            XCTFail("CatalogDataTests: неверно указана страница")
        }
        
        if catalog.products.count == 0 {
            
            XCTFail("CatalogDataTests: пустой список товаров")
        }
        
    }
    
}

