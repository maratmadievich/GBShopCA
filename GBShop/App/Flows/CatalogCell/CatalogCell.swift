//
//  CatalogCell.swift
//  GBShop
//
//  Created by Admin on 5/20/19.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit

class CatalogCell: UITableViewCell {
    
    @IBOutlet weak var labelName: UILabel!
    
    @IBOutlet weak var labelPrice: UILabel!
    
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
    }

}

extension CatalogCell: CatalogCellView {
    
    func setName(text: String) {
        
        labelName.text = text
    }
    
    func setPrice(text: String) {
        
        labelPrice.text = text
    }
    
    
    
}
