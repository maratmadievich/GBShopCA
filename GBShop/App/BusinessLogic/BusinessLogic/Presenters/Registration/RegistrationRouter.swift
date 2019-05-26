//
//  RegistrationRouter.swift
//  GBShop
//
//  Created by Марат Нургалиев on 26/05/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit

protocol RegistrationRouter: AbstractRouterFactory {
    
    init(view: RegistrationViewController)
    func showCatalogScene()
}

class RegistrationRouterImplementation: RegistrationRouter {
    
    fileprivate weak var view: RegistrationViewController?
    
    
    required init(view: RegistrationViewController) {
        self.view = view
    }
    
    func showCatalogScene() {
        view?.performSegue(withIdentifier: "showCatalogScene", sender: nil)
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        view?.navigationItem.backBarButtonItem = backItem
    }
}
