//
//  ProfileConfigurator.swift
//  GBShop
//
//  Created by Марат Нургалиев on 26/05/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation

protocol ProfileConfigurator {
    
    func configure(profileViewController: ProfileViewController)
}

class ProfileConfiguratorImplementation: ProfileConfigurator {
    
    public func configure(profileViewController: ProfileViewController) {
        
        let model = ProfileModel()
        let router = ProfileRouterImplementation(view: profileViewController)
        let presenter = ProfilePresenterImplementation(view: profileViewController, model: model, router: router)
        profileViewController.presenter = presenter
    }
}
