//
//  ProductInfoCellView.swift
//  GBShop
//
//  Created by Марат Нургалиев on 27/05/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation

protocol ProductInfoCellView: NSObjectProtocol {
    
    func setUserName(text: String)
    func setReview(text: String)
}
