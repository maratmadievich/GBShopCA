//
//  RegistrationConfigurator.swift
//  GBShop
//
//  Created by Марат Нургалиев on 26/05/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation

/// Описывает конфигуратор для окна регистрации
internal protocol RegistrationConfigurator {
    
    /// Конфигурирует model, view, presenter и router
    /// Параметры:
    /// - registrationViewController: контроллер окна Регистрации
    func configure(registrationViewController: RegistrationViewController)
}

/// Реализует Конфигуратор для окна регистрации
internal class RegistrationConfiguratorImplementation: RegistrationConfigurator {
    
    public func configure(registrationViewController: RegistrationViewController) {
        
        let model = RegistrationModel()
        let router = RegistrationRouterImplementation(view: registrationViewController)
        let presenter = RegistrationPresenterImplementation(view: registrationViewController, model: model, router: router)
        registrationViewController.presenter = presenter
    }
}

