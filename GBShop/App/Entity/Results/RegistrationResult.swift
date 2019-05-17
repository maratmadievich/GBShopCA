//
//  RegistrationResult.swift
//  GBShop
//
//  Created by Admin on 5/17/19.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation

struct RegistrationResult: Codable {
    
    let result: Int
    
    let message: String
    
    
    enum CodingKeys: String, CodingKey {
        
        case result = "result"
        
        case message = "userMessage"
    }
}
