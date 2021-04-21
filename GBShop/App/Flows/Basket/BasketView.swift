//
//  BasketView.swift
//  GBShop
//
//  Created by Admin on 5/28/19.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit

protocol BasketView: NSObjectProtocol {
    
    var presenter: BasketPresenter! {get set}
    
    func startLoading()
    func finishLoading()
    
    func refreshProducts()
    func setTotalAmout(text: String)
    func showError(text: String)
    func showSuccess(title: String, text: String)
}
