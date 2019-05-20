//
//  CatalogDataResult.swift
//  GBShop
//
//  Created by Марат Нургалиев on 26/04/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation

struct CatalogDataResult: Codable {
    
    let pageNumber: Int
    
    let maxRowsCount: Int
    
    let products: [Product]
    
    
    enum CodingKeys: String, CodingKey {
        
        case pageNumber = "page_number"
        
        case maxRowsCount = "max_rows_count"
        
        case products = "products"
    }
    
}

struct Product: Codable {
    
    let id: Int
    
    let name: String
    
    let price: Int
    
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id_product"
        
        case name = "product_name"
        
        case price = "price"
    }
    
}
