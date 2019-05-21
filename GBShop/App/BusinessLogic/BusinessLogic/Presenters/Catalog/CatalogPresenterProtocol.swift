//
//  CatalogPresenterProtocol.swift
//  GBShop
//
//  Created by Admin on 5/20/19.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation
import UIKit

protocol CatalogPresenterProtocol {
    
    init (view: CatalogView)
    
    func getCatalogRows()
    
    func refreshCatalogRows()
    
    func getRowsCount() -> Int
    
    func configure(cell: CatalogCellView, forRow row: Int)
    
    func showProfile()
    
    func changeSearchText(_ text: String)
}
