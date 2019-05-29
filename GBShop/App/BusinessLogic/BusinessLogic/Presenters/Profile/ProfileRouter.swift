//
//  ProfileRouter.swift
//  GBShop
//
//  Created by Марат Нургалиев on 26/05/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit

//Протокол Роутера для окна смены профиля
protocol ProfileRouter: AbstractRouterFactory {
    
    //Указание иинциализации роутера
    init(view: ProfileViewController)
    //Функция закрытия данного окна
    func dismiss()
}

class ProfileRouterImplementation: ProfileRouter {
    
    fileprivate weak var view: ProfileViewController?
    
    required init(view: ProfileViewController) {
        self.view = view
    }
    
    public func dismiss() {
        view?.navigationController?.popViewController(animated: true)
    }
    
    public func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        view?.navigationItem.backBarButtonItem = backItem
    }
}

