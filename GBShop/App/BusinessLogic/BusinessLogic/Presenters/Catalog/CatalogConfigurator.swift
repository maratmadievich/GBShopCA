//
//  CatalogConfigurator.swift
//  GBShop
//
//  Created by Марат Нургалиев on 26/05/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation

protocol CatalogConfigurator {
    
    func configure(catalogViewController: CatalogViewController)
}

class CatalogConfiguratorImplementation: CatalogConfigurator {
    
    public func configure(catalogViewController: CatalogViewController) {
        
        let model = CatalogModel()
        let router = CatalogRouterImplementation(view: catalogViewController)
        let presenter = CatalogPresenterImplementation(view: catalogViewController, model: model, router: router)
        catalogViewController.presenter = presenter
    }
}


