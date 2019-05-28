//
//  GetBasketRequest.swift
//  GBShop
//
//  Created by Admin on 5/13/19.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Alamofire

class GetBasketRequest: AbstractRequestFactory {
    
    let errorParser: AbstractErrorParser
    
    let sessionManager: SessionManager
    
    let queue: DispatchQueue?
    
    let baseUrl = URL(string: "http://10.12.2.82:8181/")!
    
    
    init(errorParser: AbstractErrorParser,
         sessionManager: SessionManager,
         queue: DispatchQueue? = DispatchQueue.global(qos: .utility)) {
        
        self.errorParser = errorParser
        
        self.sessionManager = sessionManager
        
        self.queue = queue
    }
    
}

extension GetBasketRequest: GetBasketRequestFactory {
    
    func getBasket(idUser: Int, completionHandler: @escaping (DataResponse<GetBasketResult>) -> Void) {
        
        let requestModel = GetBasketRequest(baseUrl: baseUrl, idUser: idUser)
        
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
}

extension GetBasketRequest {
    
    struct GetBasketRequest: RequestRouter {
        
        let baseUrl: URL
        
        let method: HTTPMethod = .get
        
        let path: String = "getBasket.json"
        
        let idUser: Int
        
        var parameters: Parameters? {
            
            return [
                "id_user" : idUser
            ]
            
        }
        
    }
    
}
