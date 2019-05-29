//
//  RegistrationRouter.swift
//  GBShop
//
//  Created by Марат Нургалиев on 26/05/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit

//Протокол Роутера для окна авторизации
protocol RegistrationRouter: AbstractRouterFactory {
    //Указание иинциализации роутера
    init(view: RegistrationViewController)
    //Функция для перехода к окну Каталога
    func showCatalogScene()
}

class RegistrationRouterImplementation: RegistrationRouter {
    
    fileprivate weak var view: RegistrationViewController?
    
    
    required init(view: RegistrationViewController) {
        self.view = view
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
