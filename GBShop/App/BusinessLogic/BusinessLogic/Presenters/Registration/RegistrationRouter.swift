//
//  RegistrationRouter.swift
//  GBShop
//
//  Created by Марат Нургалиев on 26/05/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit

///  Описывает роутер для окна регистрации
internal protocol RegistrationRouter: AbstractRouterFactory {
    
    /// Описание необходимой инициализации
    /// Параметры:
    /// - view: viewController окна регистрации
    init(view: RegistrationViewController)
    
    /// Осуществляет переход к онку Список товаров
    func showCatalogScene()
}

internal class RegistrationRouterImplementation: RegistrationRouter {
    
    fileprivate weak var view: RegistrationViewController?
    
    
    required init(view: RegistrationViewController) {
        self.view = view
    }
    
    public func showCatalogScene() {
        view?.performSegue(withIdentifier: "showCatalogScene", sender: nil)
    }
    
    /// Настраивает кнопку Назад на открывающемся экране, чтобы она была без текста
    public func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        view?.navigationItem.backBarButtonItem = backItem
    }
}
