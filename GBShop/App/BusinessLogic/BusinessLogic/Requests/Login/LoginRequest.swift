//
//  Auth.swift
//  GBShop
//
//  Created by Admin on 4/22/19.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation
import Alamofire

class LoginRequest: AbstractRequestFactory {
   
    let errorParser: AbstractErrorParser
    
    let sessionManager: SessionManager
    
    let queue: DispatchQueue?
    
    let baseUrl = URL(string: "http://192.168.1.72:8181/")!
    //10.12.2.82
    //192.168.1.72
    
    
    init(errorParser: AbstractErrorParser,
         sessionManager: SessionManager,
         queue: DispatchQueue? = DispatchQueue.global(qos: .utility)) {
        
        self.errorParser = errorParser
        
        self.sessionManager = sessionManager
        
        self.queue = queue
    }
    
}

extension LoginRequest: LoginRequestFactory {
   
    func login(userName: String, password: String, completionHandler: @escaping (DataResponse<LoginResult>) -> Void) {
    
        let requestModel = LoginRequest(baseUrl: baseUrl, login: userName, password: password)
        
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
}

extension LoginRequest {
    
    struct LoginRequest: RequestRouter {
        
        let baseUrl: URL
        
        let method: HTTPMethod = .post
        
        let path: String = "login"
        
        let login: String
        
        let password: String
        
        var parameters: Parameters? {
        
            return [
                "user_name": login,
                "password": password
            ]
            
        }
        
    }
    
}
