//
//  ProductRequest.swift
//  GBShop
//
//  Created by Марат Нургалиев on 26/04/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation
import Alamofire

class ProductRequest: AbstractRequestFactory {
    
    let errorParser: AbstractErrorParser
    
    let sessionManager: SessionManager
    
    let queue: DispatchQueue?
    
    let baseUrl = BaseUrlSingleton.instance.getUrl()
    
    
    init(errorParser: AbstractErrorParser,
         sessionManager: SessionManager,
         queue: DispatchQueue? = DispatchQueue.global(qos: .utility)) {
        
        self.errorParser = errorParser
        
        self.sessionManager = sessionManager
        
        self.queue = queue
    }
    
}

extension ProductRequest: ProductRequestFactory {
    
    func getProductBy(id: Int, completionHandler: @escaping (DataResponse<ProductResult>) -> Void) {
        
        let requestModel = ProductRequest(baseUrl: baseUrl, idProduct: id)
        
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
}

extension ProductRequest {
    
    struct ProductRequest: RequestRouter {
        
        let baseUrl: URL
        
        let method: HTTPMethod = .get
        
        let path: String = "getGoodById.json"
        
        let idProduct: Int
        
        var parameters: Parameters? {
            
            return [
                "id_product" : idProduct
            ]
            
        }
        
    }
    
}
