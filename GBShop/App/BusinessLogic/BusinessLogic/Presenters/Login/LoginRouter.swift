//
//  LoginRouter.swift
//  GBShop
//
//  Created by Марат Нургалиев on 26/05/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit

protocol LoginRouter: AbstractRouterFactory {
    
    init(view: LoginViewController)
    func showRegistrateScene()
    func showCatalogScene()
}

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
    
    public func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        view?.navigationItem.backBarButtonItem = backItem
    }
}
