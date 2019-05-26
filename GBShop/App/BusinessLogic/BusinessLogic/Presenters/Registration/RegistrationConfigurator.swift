//
//  RegistrationConfigurator.swift
//  GBShop
//
//  Created by Марат Нургалиев on 26/05/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation

protocol RegistrationConfigurator {
    
    func configure(registrationViewController: RegistrationViewController)
}

class RegistrationConfiguratorImplementation: RegistrationConfigurator {
    
    func configure(registrationViewController: RegistrationViewController) {
        
        let model = RegistrationModel()
        let router = RegistrationRouterImplementation(view: registrationViewController)
        let presenter = RegistrationPresenterImplementation(view: registrationViewController, model: model, router: router)
        registrationViewController.presenter = presenter
    }
}

