//
//  ReviewsRequest.swift
//  GBShop
//
//  Created by Марат Нургалиев on 07/05/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Alamofire

class ReviewsRequest: AbstractRequestFactory {
    
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

extension ReviewsRequest: ReviewsRequestFactory {
    
    func getReviews(idProduct: Int, pageNumber: Int, completionHandler: @escaping (DataResponse<ReviewsResult>) -> Void) {
        
        let requestModel = ReviewsRequest(baseUrl: baseUrl, idProduct: idProduct, pageNumber: pageNumber)
        
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
}

extension ReviewsRequest {
    
    struct ReviewsRequest: RequestRouter {
        
        let baseUrl: URL
        
        let method: HTTPMethod = .get
        
        let path: String = "reviews"
        
        let idProduct: Int
        
        let pageNumber: Int
        
        var parameters: Parameters? {
            
            return [
                "id_product" : idProduct,
                "page_number" : pageNumber
            ]
            
        }
        
    }
    
}


