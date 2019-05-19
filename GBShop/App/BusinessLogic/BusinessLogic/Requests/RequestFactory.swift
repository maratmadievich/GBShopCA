//
//  RequestFactory.swift
//  GBShop
//
//  Created by Admin on 4/22/19.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation
import Alamofire

class RequestFactory {
    
    func makeErrorParser() -> AbstractErrorParser {
     
        return ErrorParser()
    }
    
    
    lazy var commonSessionManager: SessionManager = {
     
        let configuration = URLSessionConfiguration.default
        
        configuration.httpShouldSetCookies = false
        
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        
        let manager = SessionManager(configuration: configuration)
        
        return manager
    }()
    
    
    let sessionQueue = DispatchQueue.global(qos: .utility)
    
    
    func makeLoginRequestFactory() -> LoginRequestFactory {
    
        let errorParser = makeErrorParser()
        
        return LoginRequest(errorParser: errorParser, sessionManager: commonSessionManager, queue: sessionQueue)
    }
    
    
    func makeRegistrationRequestFatory() -> RegistrationRequestFactory {
        
        let errorParser = makeErrorParser()
        
        return RegistrationRequest(errorParser: errorParser, sessionManager: commonSessionManager, queue: sessionQueue)
    }
    
    
    func makeLogoutRequestFatory() -> LogoutRequestFactory {
        
        let errorParser = makeErrorParser()
        
        return Logout(errorParser: errorParser, sessionManager: commonSessionManager, queue: sessionQueue)
    }
    
    
    func makeChangeProfileRequestFatory() -> ChangeProfileRequestFactory {
        
        let errorParser = makeErrorParser()
        
        return ChangeProfileRequest(errorParser: errorParser, sessionManager: commonSessionManager, queue: sessionQueue)
    }
    
    
    func makeCatalogDataRequestFatory() -> CatalogDataRequestFactory {
        
        let errorParser = makeErrorParser()
        
        return CatalogData(errorParser: errorParser, sessionManager: commonSessionManager, queue: sessionQueue)
    }
    
    
    func makeProductRequestFatory() -> ProductRequestFactory {
        
        let errorParser = makeErrorParser()
        
        return ProductRequest(errorParser: errorParser, sessionManager: commonSessionManager, queue: sessionQueue)
    }
    
    
    func makeGetReviewsRequestFatory() -> ReviewsRequestFactory {
        
        let errorParser = makeErrorParser()
        
        return ReviewsRequest(errorParser: errorParser, sessionManager: commonSessionManager, queue: sessionQueue)
    }
    
    
    func makeAddReviewRequestFatory() -> AddReviewRequestFactory {
        
        let errorParser = makeErrorParser()
        
        return AddReviewRequest(errorParser: errorParser, sessionManager: commonSessionManager, queue: sessionQueue)
    }
    
    func makeRemoveReviewRequestFatory() -> RemoveReviewRequestFactory {
        
        let errorParser = makeErrorParser()
        
        return RemoveReviewRequest(errorParser: errorParser, sessionManager: commonSessionManager, queue: sessionQueue)
    }
    
    
    func makeAddToBasketRequestFatory() -> AddToBasketRequestFactory {
        
        let errorParser = makeErrorParser()
        
        return AddToBasketRequest(errorParser: errorParser, sessionManager: commonSessionManager, queue: sessionQueue)
    }
    
    
    func makeDeleteFromBasketRequestFatory() -> DeleteFromBasketRequestFactory {
        
        let errorParser = makeErrorParser()
        
        return DeleteFromBasketRequest(errorParser: errorParser, sessionManager: commonSessionManager, queue: sessionQueue)
    }
    
    
    func makeGetBasketRequestFatory() -> GetBasketRequestFactory {
        
        let errorParser = makeErrorParser()
        
        return GetBasketRequest(errorParser: errorParser, sessionManager: commonSessionManager, queue: sessionQueue)
    }
    
}
