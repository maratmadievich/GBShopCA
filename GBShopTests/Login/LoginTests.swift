//
//  LoginTests.swift
//  GBShopTests
//
//  Created by Марат Нургалиев on 26/04/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import XCTest
import Alamofire
@testable import GBShop

class LoginTests: XCTestCase {
    
    let expectation = XCTestExpectation(description: "Тестирование метода авторизации")
    
    var requestFactory: RequestFactory!
    
    var userName: String!
    
    var password: String!
    
    
    override func setUp() {
        
        requestFactory = RequestFactory()
        
        userName = "Somebody"
        
        password = "mypassword"
    }
    
    
    override func tearDown() {
        
        requestFactory = nil
        
        userName = nil
        
        password = nil
    }
    
    
    func testLogin() {
        
        let loginRequest = requestFactory.makeLoginRequestFactory()
        
        loginRequest.login(userName: userName, password: password) { response in
            
            switch response.result {
                
            case .success(let loginResponse):
                
                self.checkLoginResult(loginResponse)
                
                break
                
            case .failure(let error):
                
                XCTFail("LoginTests: \(error.localizedDescription)")
            }
            
            self.expectation.fulfill()
            
        }
        
        wait(for: [expectation], timeout: 10.0)
        
    }
    
    
    private func checkLoginResult(_ login: LoginResult) {
        
        if login.result != 1 {
            
            XCTFail("LoginTests: неверный ответ от сервера")
        }
        
        if login.user.id < 1 {
            
            XCTFail("LoginTests: id пользователя некорректен")
        }
        
        if login.user.login.trimmingCharacters(in: .whitespacesAndNewlines).count == 0 {
            
            XCTFail("LoginTests: Логин пользователя пуст")
        }
        
    }
    
}
