//
//  RegistrationRequestFactory.swift
//  GBShop
//
//  Created by Admin on 5/17/19.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Alamofire

protocol RegistrationRequestFactory {
    
    func registrate(userName: String,
                    password: String,
                    email: String,
                    gender: String,
                    completionHandler: @escaping (DataResponse<RegistrationResult>) -> Void)
    
}
