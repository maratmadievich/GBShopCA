//
//  AddReviewResult.swift
//  GBShop
//
//  Created by Марат Нургалиев on 07/05/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation

struct AddReviewResult: Codable {
    
    let result: Int
    
    let message: String
    
    
    enum CodingKeys: String, CodingKey {
        
        case result = "result"
        
        case message = "userMessage"
    }
}
