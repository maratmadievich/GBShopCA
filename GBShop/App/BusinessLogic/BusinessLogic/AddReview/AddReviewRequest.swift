//
//  AddReviewRequest.swift
//  GBShop
//
//  Created by Марат Нургалиев on 07/05/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Alamofire

class AddReviewRequest: AbstractRequestFactory {
    
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

extension AddReviewRequest: AddReviewRequestFactory {
    
    func addReview(idUser: Int, idProduct: Int, text: String, completionHandler: @escaping (DataResponse<AddReviewResult>) -> Void) {
        
        let requestModel = AddReviewRequest(baseUrl: baseUrl, idUser: idUser, idProduct: idProduct, text: text)
        
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
}

extension AddReviewRequest {
    
    struct AddReviewRequest: RequestRouter {
        
        let baseUrl: URL
        
        let method: HTTPMethod = .get
        
        let path: String = "addReview.json"
        
        let idUser: Int
        
        let idProduct: Int
        
        let text: String
        
        var parameters: Parameters? {
            
            return [
                "id_user" : idUser,
                "id_product" : idProduct,
                "text" : text
            ]
            
        }
        
    }
    
}
