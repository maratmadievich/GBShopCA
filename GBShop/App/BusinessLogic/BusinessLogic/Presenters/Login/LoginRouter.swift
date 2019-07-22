//
//  LoginRouter.swift
//  GBShop
//
//  Created by Марат Нургалиев on 26/05/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit

///  Описывает роутер для окна авторизации
internal protocol LoginRouter: AbstractRouterFactory {
    
    /// Описание необходимой инициализации
    /// Параметры:
    /// - view: viewController окна авторизации
    init(view: LoginViewController)
    
    /// Осуществляет переход к онку Регистрация
    func showRegistrateScene()
    
    /// Осуществляет переход к онку Список товаров
    func showCatalogScene()
}

//Реализация Роутера для окна авторизации
internal class LoginRouterImplementation: LoginRouter {
    
    fileprivate weak var view: LoginViewController?
    
    required init(view: LoginViewController) {
        self.view = view
    }
    
    public func showRegistrateScene() {
        view?.performSegue(withIdentifier: "showRegistrateScene", sender: nil)
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
