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
    
    
    func makeAuthRequestFatory() -> AuthRequestFactory {
    
        let errorParser = makeErrorParser()
        
        return Auth(errorParser: errorParser, sessionManager: commonSessionManager, queue: sessionQueue)
    }
    
    
    func makeLogoutRequestFatory() -> LogoutRequestFactory {
        
        let errorParser = makeErrorParser()
        
        return Logout(errorParser: errorParser, sessionManager: commonSessionManager, queue: sessionQueue)
    }
    
    
    func makeChangeProfileRequestFatory() -> ChangeProfileRequestFactory {
        
        let errorParser = makeErrorParser()
        
        return ChangeProfile(errorParser: errorParser, sessionManager: commonSessionManager, queue: sessionQueue)
    }
    
}
