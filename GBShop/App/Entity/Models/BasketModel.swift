//
//  BasketModel.swift
//  GBShop
//
//  Created by Admin on 5/28/19.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation

struct BasketModel {
    
    var amount: Double
    var products: [ProductFromBasket]
    
    init() {
        amount = 0
        products = [ProductFromBasket]()
    }
}
