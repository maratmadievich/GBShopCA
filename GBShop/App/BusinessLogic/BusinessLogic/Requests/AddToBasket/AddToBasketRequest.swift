//
//  AddToBasketRequest.swift
//  GBShop
//
//  Created by Admin on 5/13/19.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Alamofire

class AddToBasketRequest: AbstractRequestFactory {
    
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

extension AddToBasketRequest: AddToBasketRequestFactory {
    
    func addToBasket(idProduct: Int, quantity: Int, completionHandler: @escaping (DataResponse<AddToBasketResult>) -> Void) {
        
        let requestModel = AddToBasketRequest(baseUrl: baseUrl, idProduct: idProduct, quantity: quantity)
        
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
}

extension AddToBasketRequest {
    
    struct AddToBasketRequest: RequestRouter {
        
        let baseUrl: URL
        
        let method: HTTPMethod = .get
        
        let path: String = "addToBasket.json"
        
        let idProduct: Int
        
        let quantity: Int
        
        var parameters: Parameters? {
            
            return [
                "id_product" : idProduct,
                "quantity" : quantity
            ]
            
        }
        
    }
    
}

