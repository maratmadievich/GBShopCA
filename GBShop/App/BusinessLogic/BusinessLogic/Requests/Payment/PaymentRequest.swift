//
//  PaymentRequest.swift
//  GBShop
//
//  Created by Марат Нургалиев on 28/05/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation
import Alamofire

class PaymentRequest: AbstractRequestFactory {
    
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

extension PaymentRequest: PaymentRequestFactory {
    
    func payment(completionHandler: @escaping (DataResponse<PaymentResult>) -> Void) {
        
        let requestModel = PaymentRequest(baseUrl: baseUrl)
        
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
}

extension PaymentRequest {
    
    struct PaymentRequest: RequestRouter {
        
        let baseUrl: URL
        
        let method: HTTPMethod = .post
        
        let path: String = "payment"
        
        
        var parameters: Parameters? {
            
            return nil
        }
        
    }
    
}

