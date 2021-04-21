//
//  LoginConfigurator.swift
//  GBShop
//
//  Created by Марат Нургалиев on 26/05/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation

/// Описывает конфигуратор для окна авторизации
internal protocol LoginConfigurator {
    
    /// Конфигурирует model, view, presenter и router
    /// Параметры:
    /// - loginViewController: контроллер окна Авторизации
    func configure(loginViewController: LoginViewController)
}

/// Реализует Конфигуратор для окна авторизации
internal class LoginConfiguratorImplementation: LoginConfigurator {
    
    internal func configure(loginViewController: LoginViewController) {
        let model = LoginModel()
        let router = LoginRouterImplementation(view: loginViewController)
        let presenter = LoginPresenterImplementation(view: loginViewController, model: model, router: router)
        loginViewController.presenter = presenter
    }
}
