//
//  CatalogData.swift
//  GBShop
//
//  Created by Марат Нургалиев on 26/04/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation
import Alamofire

class CatalogData: AbstractRequestFactory {
    
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

extension CatalogData: CatalogDataRequestFactory {
    
    func getCatalogData(pageNumber: Int, idCategory: Int, completionHandler: @escaping (DataResponse<CatalogDataResult>) -> Void) {
        
        let requestModel = CatalogData(baseUrl: baseUrl, pageNumber: pageNumber, idCategory: idCategory)
        
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
}

extension CatalogData {
    
    struct CatalogData: RequestRouter {
        
        let baseUrl: URL
        
        let method: HTTPMethod = .get
        
        let path: String = "catalogData.json"
        
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
