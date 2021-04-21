//
//  ProfileConfigurator.swift
//  GBShop
//
//  Created by Марат Нургалиев on 26/05/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation

//Протокол Конфигуратора для окна смены профиля
protocol ProfileConfigurator {
    
    //Описание функции по конфигурированию profileViewController
    func configure(profileViewController: ProfileViewController)
}

//Реализация Конфигуратора для окна смены профиля
class ProfileConfiguratorImplementation: ProfileConfigurator {
    
    public func configure(profileViewController: ProfileViewController) {
        
        let model = ProfileModel()
        let router = ProfileRouterImplementation(view: profileViewController)
        let presenter = ProfilePresenterImplementation(view: profileViewController, model: model, router: router)
        profileViewController.presenter = presenter
    }
}
