//
//  LogoutRequestFactory.swift
//  GBShop
//
//  Created by Admin on 4/22/19.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation

protocol LogoutRequestFactory {
    
    func logout(completionHandler: @escaping (DataResponse<LogoutResult>) -> Void)
    
}
