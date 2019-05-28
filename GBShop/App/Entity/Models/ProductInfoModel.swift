//
//  ProductInfoModel.swift
//  GBShop
//
//  Created by Марат Нургалиев on 27/05/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation

struct ProductInfoModel {
    
    var product: Product
    var pageNumber: Int
    var maxReviewsCount: Int
    
    var reviews: [Review]
    
    init(product: Product) {
        self.product = product
        pageNumber = 0
        maxReviewsCount = 1000
        reviews = [Review]()
    }
}

