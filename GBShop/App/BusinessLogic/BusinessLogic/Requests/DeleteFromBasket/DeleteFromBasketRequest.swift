//
//  DeleteFromBasketRequest.swift
//  GBShop
//
//  Created by Admin on 5/13/19.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Alamofire

class DeleteFromBasketRequest: AbstractRequestFactory {
    
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

extension DeleteFromBasketRequest: DeleteFromBasketRequestFactory {
    
    func deleteFromBasket(idProduct: Int, completionHandler: @escaping (DataResponse<DeleteFromBasketResult>) -> Void) {
        
        let requestModel = DeleteFromBasketRequest(baseUrl: baseUrl, idProduct: idProduct)
        
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
}

extension DeleteFromBasketRequest {
    
    struct DeleteFromBasketRequest: RequestRouter {
        
        let baseUrl: URL
        
        let method: HTTPMethod = .get
        
        let path: String = "deleteFromBasket.json"
        
        let idProduct: Int
        
        var parameters: Parameters? {
            
            return [
                "id_product" : idProduct
            ]
            
        }
        
    }
    
}

