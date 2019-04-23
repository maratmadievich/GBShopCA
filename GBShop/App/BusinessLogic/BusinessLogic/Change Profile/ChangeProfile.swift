//
//  ChangeProfile.swift
//  GBShop
//
//  Created by Admin on 4/23/19.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation
import Alamofire

class ChangeProfile: AbstractRequestFactory {
    
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

extension ChangeProfile: ChangeProfileRequestFactory {
    
    
    func changeProfile(idUser: Int, userName: String, password: String, email: String, gender: String, creditCard: String, bio: String, completionHandler: @escaping (DataResponse<ChangeProfileResult>) -> Void) {
        
        let requestModel = ChangeProfile(baseUrl: baseUrl, idUser: idUser, userName: userName, password: password, email: email, gender: gender, creditCard: creditCard, bio: bio)
        
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
}

extension ChangeProfile {
    
    struct ChangeProfile: RequestRouter {
        
        let baseUrl: URL
        
        let method: HTTPMethod = .get
        
        let path: String = "changeUserData.json"
        
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


/*
 
 "id_user" : 123
 "username" : "Somebody",
 "password" : "mypassword",
 "email" : "some@some.ru",
 "gender": "m",
 "credit_card" : "9872389-2424-234224-234",
 "bio" : "This is good! I think I will switch to another language"
 
 
 */
