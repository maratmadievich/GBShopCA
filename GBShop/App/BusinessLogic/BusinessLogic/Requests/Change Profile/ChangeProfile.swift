//
//  ChangeProfile.swift
//  GBShop
//
//  Created by Admin on 4/23/19.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation
import Alamofire

class ChangeProfileRequest: AbstractRequestFactory {
    
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

extension ChangeProfileRequest: ChangeProfileRequestFactory {
    
    func changeProfile(idUser: Int, userName: String, password: String, email: String, gender: String, creditCard: String, bio: String, completionHandler: @escaping (DataResponse<ChangeProfileResult>) -> Void) {
        
        let requestModel = ChangeProfileRequest(baseUrl: baseUrl, idUser: idUser, userName: userName, password: password, email: email, gender: gender, creditCard: creditCard, bio: bio)
        
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
}

extension ChangeProfileRequest {
    
    struct ChangeProfileRequest: RequestRouter {
        
        let baseUrl: URL
        
        let method: HTTPMethod = .post
        
        let path: String = "change_profile"
        
        let idUser: Int
        
        let userName: String
        
        let password: String
        
        let email: String
        
        let gender: String
        
        let creditCard: String
        
        let bio: String
        
        var parameters: Parameters? {
            
            return [
                "id_user" : idUser,
                "user_name" : userName,
                "password" : password,
                "email" : email,
                "gender": gender,
                "credit_card" : creditCard,
                "bio" : bio
            ]
            
        }
        
    }
    
}

