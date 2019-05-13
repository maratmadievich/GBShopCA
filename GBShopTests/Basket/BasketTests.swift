//
//  BasketTests.swift
//  GBShopTests
//
//  Created by Admin on 5/13/19.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import XCTest
import Alamofire
@testable import GBShop

class BasketTests: XCTestCase {
    
    let expectation = XCTestExpectation(description: "Тестирование методов работы с корзиной")
    
    var requestFactory: RequestFactory!
    
    var idUser: Int!
    
    var idProduct: Int!
    
    var quantity: Int!
    
    
    override func setUp() {
        
        requestFactory = RequestFactory()
        
        idUser = 1
        
        quantity = 2
        
        idProduct = 123
    }
    
    
    override func tearDown() {
        
        idUser = nil
        
        quantity = nil
        
        idProduct = nil
        
        requestFactory = nil
    }
    
    
    func testAddToBasket() {
        
        let addToBasketRequest = requestFactory.makeAddToBasketRequestFatory()
        
        addToBasketRequest.addToBasket(idProduct: idProduct, quantity: quantity) { response in
            
            switch response.result {
                
            case .success(let addToBasketResult):
                
                self.checkAddToBasketResult(addToBasketResult)
                
                break
                
            case .failure(let error):
                
                XCTFail("BasketTests: \(error.localizedDescription)")
            }
            
            self.expectation.fulfill()
            
        }
        
        wait(for: [expectation], timeout: 10.0)
        
    }
    
    
    private func checkAddToBasketResult(_ addToBasketResult: AddToBasketResult) {
        
        if addToBasketResult.result != 1 {
            
            XCTFail("BasketTests: неверный ответ от сервера")
        }
        
    }
    
    
    func testDeleteFromBasket() {
        
        let deleteFromBasketRequest = requestFactory.makeDeleteFromBasketRequestFatory()
        
        deleteFromBasketRequest.deleteFromBasket(idProduct: idProduct) { response in
            
            switch response.result {
                
            case .success(let deleteFromBasketResult):
                
                self.checkDeleteFromBasketResult(deleteFromBasketResult)
                
                break
                
            case .failure(let error):
                
                XCTFail("ReviewsTests: \(error.localizedDescription)")
            }
            
            self.expectation.fulfill()
            
        }
        
        wait(for: [expectation], timeout: 10.0)
        
    }
    
    
    private func checkDeleteFromBasketResult(_ deleteFromBasketResult: DeleteFromBasketResult) {
        
        if deleteFromBasketResult.result != 1 {
            
            XCTFail("BasketTests: неверный ответ от сервера")
        }
        
    }
    
    
    func testGetBasket() {
        
        let getBasketRequest = requestFactory.makeGetBasketRequestFatory()
        
        getBasketRequest.getBasket(idUser: idUser) { response in
            
            switch response.result {
                
            case .success(let getBasketResult):
                
                self.checkGetBasketResult(getBasketResult)
                
                break
                
            case .failure(let error):
                
                XCTFail("BasketTests: \(error.localizedDescription)")
            }
            
            self.expectation.fulfill()
            
        }
        
        wait(for: [expectation], timeout: 10.0)
        
    }
    
    
    private func checkGetBasketResult(_ getBasketResult: GetBasketResult) {
        
        if getBasketResult.amount > 0 && getBasketResult.countGoods == 0 {
            
            XCTFail("BasketTests: в корзине нет товара, но указана цена")
        }
        
        if getBasketResult.countGoods != getBasketResult.products.count {
            
            XCTFail("BasketTests: количество товаров не равно количеству описаний товаров")
        }
        
        for product in getBasketResult.products {
            
            if product.id <= 0 {
                
                XCTFail("BasketTests: id товара имеет неверное значение")
            }
            
            if product.name.trimmingCharacters(in: .whitespacesAndNewlines).count == 0 {
                
                XCTFail("BasketTests: название товара имеет пустое значение")
            }
            
            if product.quantity <= 0 {
                
                XCTFail("BasketTests: количество товара (\(product.id): \(product.name)) имеет неверное значение")
            }
            
        }
        
    }
    
}
