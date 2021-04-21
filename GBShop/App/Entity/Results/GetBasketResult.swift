//
//  GetBasketResult.swift
//  GBShop
//
//  Created by Admin on 5/13/19.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation

struct GetBasketResult: Codable {
    
    let amount: Double
    
    let countGoods: Int
    
    let products: [ProductFromBasket]
    
    
    enum CodingKeys: String, CodingKey {
        
        case amount = "amount"
        
        case countGoods = "count_goods"
        
        case products = "contents"
    }
    
}

struct ProductFromBasket: Codable {
    
    let id: Int
    
    let name: String
    
    let price: Int
    
    let quantity: Int
    
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id_product"
        
        case name = "product_name"
        
        case price = "price"
        
        case quantity = "quantity"
    }
    
}

