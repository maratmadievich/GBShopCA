//
//  CatalogData.swift
//  GBShop
//
//  Created by Марат Нургалиев on 26/04/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation
import Alamofire

class CatalogDataRequest: AbstractRequestFactory {
    
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

extension CatalogDataRequest: CatalogDataRequestFactory {
    
    func getCatalogData(pageNumber: Int, idCategory: Int, completionHandler: @escaping (DataResponse<CatalogDataResult>) -> Void) {
        
        let requestModel = CatalogDataRequest(baseUrl: baseUrl, pageNumber: pageNumber, idCategory: idCategory)
        
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
}

extension CatalogDataRequest {
    
    struct CatalogDataRequest: RequestRouter {
        
        let baseUrl: URL
        
        let method: HTTPMethod = .get
        
        let path: String = "catalog"
        
        let pageNumber: Int
        
        let idCategory: Int
        
        var parameters: Parameters? {
            
            return [
                "page_number" : pageNumber,
                "id_category" : idCategory
            ]
            
        }
        
    }
    
}
