//
//  RegistrationRequest.swift
//  GBShop
//
//  Created by Admin on 5/17/19.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation
import Alamofire

class RegistrationRequest: AbstractRequestFactory {
    
    let errorParser: AbstractErrorParser
    
    let sessionManager: SessionManager
    
    let queue: DispatchQueue?
    
    let baseUrl = URL(string: "http://192.168.1.72:8181/")!
    
    
    init(errorParser: AbstractErrorParser,
         sessionManager: SessionManager,
         queue: DispatchQueue? = DispatchQueue.global(qos: .utility)) {
        
        self.errorParser = errorParser
        
        self.sessionManager = sessionManager
        
        self.queue = queue
    }
    
}

extension RegistrationRequest: RegistrationRequestFactory {
    
    func registrate(userName: String, password: String, email: String, gender: String, completionHandler: @escaping (DataResponse<RegistrationResult>) -> Void) {
        
        let requestModel = RegistrationRequest(baseUrl: baseUrl, userName: userName, password: password, email: email, gender: gender)
        
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
}

extension RegistrationRequest {
    
    struct RegistrationRequest: RequestRouter {
        
        let baseUrl: URL
        
        let method: HTTPMethod = .post
        
        let path: String = "registration"
        
        let userName: String
        
        let password: String
        
        let email: String
        
        let gender: String
        
        var parameters: Parameters? {
            
            return [
                "user_name" : userName,
                "password" : password,
                "email" : email,
                "gender": gender
            ]
            
        }
        
    }
    
}
