//
//  CatalogViewProtocol.swift
//  GBShop
//
//  Created by Admin on 5/20/19.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation
import UIKit

protocol CatalogView: NSObjectProtocol {
    
    var presenter: CatalogPresenterProtocol! {get set}
    
    func startLoading()
    
    func finishLoading()
    
    func showView(viewController: UIViewController)
    
    func showError(text: String)
    
    func refreshCatalogView()
    
}
