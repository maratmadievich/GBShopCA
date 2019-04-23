//
//  ChangeProfileRequestFactory.swift
//  GBShop
//
//  Created by Admin on 4/23/19.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation
import Alamofire

protocol ChangeProfileRequestFactory {
    
    func changeProfile(idUser: Int,
                       userName: String,
                       password: String,
                       email: String,
                       gender: String,
                       creditCard: String,
                       bio: String,
               completionHandler: @escaping (DataResponse<ChangeProfileResult>) -> Void)
    
}

