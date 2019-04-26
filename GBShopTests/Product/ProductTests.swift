//
//  ProductTests.swift
//  GBShopTests
//
//  Created by Марат Нургалиев on 26/04/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import XCTest
import Alamofire
@testable import GBShop

class ProductTests: XCTestCase {
    
    let expectation = XCTestExpectation(description: "Тестирование метода получения товара по id")
    
    var requestFactory: RequestFactory!
    
    var idProduct: Int!
    
    
    override func setUp() {
        
        requestFactory = RequestFactory()
        
        idProduct = 1
    }
    
    
    override func tearDown() {
        
        requestFactory = nil
        
        idProduct = nil
    }
    
    
    func testGetProduct() {
        
        let pruductRequest = requestFactory.makeProductRequestFatory()
        
        pruductRequest.getProductBy(id: idProduct) { response in
            
            switch response.result {
                
            case .success(let product):
                
                self.checkProductResult(product)
                
                break
                
            case .failure(let error):
                
                XCTFail("ProductTests: \(error.localizedDescription)")
            }
            
            self.expectation.fulfill()
            
        }
        
        wait(for: [expectation], timeout: 10.0)
        
    }
    
    
    private func checkProductResult(_ product: ProductResult) {
        
        if product.result != 1 {
            
            XCTFail("ProductTests: неверный ответ от сервера")
        }
        
        if product.name.trimmingCharacters(in: .whitespacesAndNewlines).count == 0 {
            
            XCTFail("ProductTests: пустое имя товара")
        }
        
        if product.price <= 0 {
            
            XCTFail("ProductTests: неверно указана цена товара")
        }
        
    }
    
}
