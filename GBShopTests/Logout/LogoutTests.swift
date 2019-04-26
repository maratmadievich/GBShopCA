//
//  LogoutTests.swift
//  GBShopTests
//
//  Created by Марат Нургалиев on 26/04/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import XCTest
import Alamofire
@testable import GBShop

class LogoutTests: XCTestCase {
    
    let expectation = XCTestExpectation(description: "Тестирование метода разлогирования")
    
    var requestFactory: RequestFactory!
    
    var idUser: Int!
    
    
    override func setUp() {
        
        requestFactory = RequestFactory()
        
        idUser = 123
    }
    
    
    override func tearDown() {
        
        requestFactory = nil
        
        idUser = nil
    }
    
    
    func testLogout() {
        
        let logout = requestFactory.makeLogoutRequestFatory()
        
        logout.logout(idUser: idUser) { response in
            
            switch response.result {
                
            case .success(let logout):
                
                self.checkLogoutResult(logout)
                
                break
                
            case .failure(let error):
                
                XCTFail("LogoutTests: \(error.localizedDescription)")
            }
            
            self.expectation.fulfill()
            
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    
    private func checkLogoutResult(_ logout: LogoutResult) {
        
        if logout.result != 1 {
            
            XCTFail("LogoutTests: неверный ответ от сервера")
        }
        
        
    }
    
}
