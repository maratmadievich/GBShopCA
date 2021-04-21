//
//  CatalogConfigurator.swift
//  GBShop
//
//  Created by Марат Нургалиев on 26/05/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation

/// Описывает конфигуратор для окна списка товаров
internal protocol CatalogConfigurator {
    
    /// Конфигурирует model, view, presenter и router
    /// Параметры:
    /// - catalogViewController: контроллер окна Авторизации
    func configure(catalogViewController: CatalogViewController)
}

internal class CatalogConfiguratorImplementation: CatalogConfigurator {
    
    public func configure(catalogViewController: CatalogViewController) {
        
        let model = CatalogModel()
        let router = CatalogRouterImplementation(view: catalogViewController)
        let presenter = CatalogPresenterImplementation(view: catalogViewController, model: model, router: router)
        catalogViewController.presenter = presenter
    }
}


