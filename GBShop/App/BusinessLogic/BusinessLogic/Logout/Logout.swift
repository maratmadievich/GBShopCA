//
//  Logout.swift
//  GBShop
//
//  Created by Admin on 4/22/19.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation
import Alamofire

class Logout: AbstractRequestFactory {
    
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

extension Logout: LogoutRequestFactory {
    
    func logout(idUser: Int, completionHandler: @escaping (DataResponse<LogoutResult>) -> Void) {
        
        let requestModel = Logout(baseUrl: baseUrl, idUser: idUser)
        
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
}

extension Logout {
    
    struct Logout: RequestRouter {
        
        let baseUrl: URL
        
        let method: HTTPMethod = .get
        
        let path: String = "logout.json"
        
        let idUser: Int
        
        var parameters: Parameters? {
            
            return [
                "id_user": idUser
            ]
            
        }
        
    }
    
}
