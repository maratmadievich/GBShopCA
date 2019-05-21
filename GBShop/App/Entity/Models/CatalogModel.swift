//
//  CatalogModel.swift
//  GBShop
//
//  Created by Admin on 5/20/19.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation

struct CatalogModel {
    
    var pageNumber: Int
    
    var idCategory: Int
    
    var maxRowsCount: Int
    
    var isSearchable: Bool
    
    var products: [Product]
    
    var searchProducts: [Product]
    
    
    init() {
        
        pageNumber = 0
        
        idCategory = 1
        
        maxRowsCount = 1000
        
        isSearchable = false
        
        products = [Product]()
        
        searchProducts = [Product]()
    }
    
}
