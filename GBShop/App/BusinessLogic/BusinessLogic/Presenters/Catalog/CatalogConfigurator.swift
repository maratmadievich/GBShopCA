//
//  CatalogConfigurator.swift
//  GBShop
//
//  Created by Марат Нургалиев on 26/05/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation

//Протокол Конфигуратора для окна списка товаров
protocol CatalogConfigurator {
    
    //Описание функции по конфигурированию catalogViewController
    func configure(catalogViewController: CatalogViewController)
}

//Реализация Конфигуратора для окна списка товаров
class CatalogConfiguratorImplementation: CatalogConfigurator {
    
    public func configure(catalogViewController: CatalogViewController) {
        
        let model = CatalogModel()
        let router = CatalogRouterImplementation(view: catalogViewController)
        let presenter = CatalogPresenterImplementation(view: catalogViewController, model: model, router: router)
        catalogViewController.presenter = presenter
    }
}


