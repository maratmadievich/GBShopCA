//
//  LoginConfigurator.swift
//  GBShop
//
//  Created by Марат Нургалиев on 26/05/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation

//Протокол Конфигуратора для окна авторизации
protocol LoginConfigurator {
    
    //Описание функции по конфигурированию loginViewController
    func configure(loginViewController: LoginViewController)
}

//Реализация Конфигуратора для окна авторизации
class LoginConfiguratorImplementation: LoginConfigurator {
    
    public func configure(loginViewController: LoginViewController) {
        let model = LoginModel()
        let router = LoginRouterImplementation(view: loginViewController)
        let presenter = LoginPresenterImplementation(view: loginViewController, model: model, router: router)
        loginViewController.presenter = presenter
    }
}
