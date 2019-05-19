//
//  LogoutRequestFactory.swift
//  GBShop
//
//  Created by Admin on 4/22/19.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation
import Alamofire

protocol LogoutRequestFactory {
    
    func logout(idUser: Int, completionHandler: @escaping (DataResponse<LogoutResult>) -> Void)
    
}
