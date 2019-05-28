//
//  BasketConfigurator.swift
//  GBShop
//
//  Created by Admin on 5/28/19.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation

protocol BasketConfigurator {
    
    func configure(basketViewController: BasketViewController)
}

class BasketConfiguratorImplementation: BasketConfigurator {
    
    public func configure(basketViewController: BasketViewController) {
        
        let model = BasketModel()
        let router = BasketRouterImplementation(view: basketViewController)
        let presenter = BasketPresenterImplementation(view: basketViewController, model: model, router: router)
        basketViewController.presenter = presenter
    }
}
