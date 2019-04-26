//
//  ChangeProfileTests.swift
//  GBShopTests
//
//  Created by Марат Нургалиев on 26/04/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import XCTest
import Alamofire
@testable import GBShop

class ChangeProfileTests: XCTestCase {
    
    let expectation = XCTestExpectation(description: "Тестирование метода смены профиля")
    
    var requestFactory: RequestFactory!
    
    var idUser: Int!
    
    var userName: String!
    
    var password: String!
    
    var email: String!
    
    var gender: String!
    
    var creditCard: String!
    
    var bio: String!
    
    
    
    override func setUp() {
        
        requestFactory = RequestFactory()
        
        idUser = 123
        
        userName = "maratmadievich"
        
        password = "geekbrains"
        
        email = "my@gmail.com"
        
        gender = "m"
        
        creditCard = "1234-1234-1234-1234"
        
        bio = "Some text"
    }
    
    
    override func tearDown() {
        
        requestFactory = nil
        
        idUser = nil
        
        userName = nil
        
        password = nil
        
        email = nil
        
        gender = nil
        
        creditCard = nil
        
        bio = nil
    }
    
    
    func testLogout() {
        
        let profile = requestFactory.makeChangeProfileRequestFatory()
        
        profile.changeProfile(idUser: idUser,
                              userName: userName,
                              password: password,
                              email: email,
                              gender: gender,
                              creditCard: creditCard,
                              bio: bio) { response in
                                
                                switch response.result {
                                    
                                case .success(let profile):
                                    
                                    self.checkChangeProfileResult(profile)
                                    
                                case .failure(let error):
                                    
                                    XCTFail("ChangeProfileTests: \(error.localizedDescription)")
                                }
                                
                                self.expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    
    private func checkChangeProfileResult(_ profile: ChangeProfileResult) {
        
        if profile.result != 1 {
            
            XCTFail("ChangeProfileTests: неверный ответ от сервера")
        }
        
    }
    
}

