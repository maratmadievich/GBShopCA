//
//  ProductInfoConfigurator.swift
//  GBShop
//
//  Created by Марат Нургалиев on 27/05/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation

protocol ProductInfoConfigurator {
    
    func configure(productInfoController: ProductInfoViewController, product: Product)
}

class ProductInfoConfiguratorImplementation: ProductInfoConfigurator {
    
    public func configure(productInfoController: ProductInfoViewController, product: Product) {
        
        let model = ProductInfoModel(product: product)
        let router = ProductInfoRouterImplementation(view: productInfoController)
        let presenter = ProductInfoPresenterImplementation(view: productInfoController, model: model, router: router)
        productInfoController.presenter = presenter
    }
}
