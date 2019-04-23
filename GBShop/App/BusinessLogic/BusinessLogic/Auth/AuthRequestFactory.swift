//
//  AuthRequestFactory.swift
//  GBShop
//
//  Created by Admin on 4/22/19.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation
import Alamofire

protocol AuthRequestFactory {
    
    func login(userName: String,
               password: String,
               completionHandler: @escaping (DataResponse<LoginResult>) -> Void)
    
}
