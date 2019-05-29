//
//  LoginRouter.swift
//  GBShop
//
//  Created by Марат Нургалиев on 26/05/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit

//Протокол Роутера для окна авторизации
protocol LoginRouter: AbstractRouterFactory {
    //Указание иинциализации роутера
    init(view: LoginViewController)
    //Функция для перехода к окну Регистрации
    func showRegistrateScene()
    //Функция для перехода к окну Каталога
    func showCatalogScene()
}

//Реализация Роутера для окна авторизации
class LoginRouterImplementation: LoginRouter {
    
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
    
    //Функция для настройки открываяющихся контроллеров перед самим переходом
    public func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        view?.navigationItem.backBarButtonItem = backItem
    }
}
