//
//  BasketCellView.swift
//  GBShop
//
//  Created by Admin on 5/28/19.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation

protocol BasketCellView: NSObjectProtocol {
    
    func setProductName(text: String)
    func setProductCount(text: String)
    func setProductPrice(text: String)
}
