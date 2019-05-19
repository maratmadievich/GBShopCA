//
//  ReviewsResult.swift
//  GBShop
//
//  Created by Марат Нургалиев on 07/05/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation

struct ReviewsResult: Codable {
    
    let result: Int
    
    let reviews: [Review]
    
    
    enum CodingKeys: String, CodingKey {
        
        case result = "result"
        
        case reviews = "reviews"
    }
    
}

struct Review: Codable {
    
    let idProduct: Int
    
    let idUser: Int
    
    let text: String
    
    
    enum CodingKeys: String, CodingKey {
        
        case idProduct = "id_product"
        
        case idUser = "idUser"
        
        case text = "text"
    }
    
}
