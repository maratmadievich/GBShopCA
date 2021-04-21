//
//  BasketTableViewCell.swift
//  GBShop
//
//  Created by Admin on 5/28/19.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit

class BasketTableViewCell: UITableViewCell {

    @IBOutlet weak var labelProductName: UILabel!
    @IBOutlet weak var labelProductCount: UILabel!
    @IBOutlet weak var labelProductPrice: UILabel!
}

extension BasketTableViewCell: BasketCellView {
    
    func setProductName(text: String) {
        labelProductName.text = text
    }
    
    func setProductCount(text: String) {
        labelProductCount.text = text
    }
    
    func setProductPrice(text: String) {
        labelProductPrice.text = text
    }
    
    
    
}
