//
//  ProductInfoTableViewCell.swift
//  GBShop
//
//  Created by Марат Нургалиев on 27/05/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit

class ProductInfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var labelUserName: UILabel!
    @IBOutlet weak var labelReviewText: UILabel!
}

extension ProductInfoTableViewCell: ProductInfoCellView {
    
    func setUserName(text: String) {
        labelUserName.text = text
    }
    
    func setReview(text: String) {
        labelReviewText.text = text
    }
    
}
