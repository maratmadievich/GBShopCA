//
//  ProductInfoView.swift
//  GBShop
//
//  Created by Марат Нургалиев on 27/05/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit

protocol ProductInfoView: NSObjectProtocol {
    
    var presenter: ProductInfoPresenter! {get set}
    
    func setProductName(text: String)
    func setProductPrice(text: String)
    func startLoading()
    func finishLoading()
    func showError(text: String)
    func refreshReviews()
}
