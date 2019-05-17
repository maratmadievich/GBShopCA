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
    
    let baseUrl = URL(string: "https://raw.githubusercontent.com/GeekBrainsTutorial/online-store-api/master/responses/")!
    
    
    init(errorParser: AbstractErrorParser,
         sessionManager: SessionManager,
         queue: DispatchQueue? = DispatchQueue.global(qos: .utility)) {
        
        self.errorParser = errorParser
        
        self.sessionManager = sessionManager
        
        self.queue = queue
    }
    
}

extension RegistrationRequest: RegistrationRequestFactory {
    
    func registrate(userName: String, password: String, email: String, gender: String, creditCard: String, bio: String, completionHandler: @escaping (DataResponse<RegistrationResult>) -> Void) {
        
        let requestModel = RegistrationRequest(baseUrl: baseUrl, userName: userName, password: password, email: email, gender: gender, creditCard: creditCard, bio: bio)
        
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
}

extension RegistrationRequest {
    
    struct RegistrationRequest: RequestRouter {
        
        let baseUrl: URL
        
        let method: HTTPMethod = .get
        
        let path: String = "registration.json"
        
        let userName: String
        
        let password: String
        
        let email: String
        
        let gender: String
        
        let creditCard: String
        
        let bio: String
        
        var parameters: Parameters? {
            
            return [
                "username" : userName,
                "password" : password,
                "email" : email,
                "gender": gender,
                "credit_card" : creditCard,
                "bio" : bio
            ]
            
        }
        
    }
    
}
