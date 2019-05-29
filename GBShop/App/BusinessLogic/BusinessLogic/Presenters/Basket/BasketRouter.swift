//
//  BasketRouter.swift
//  GBShop
//
//  Created by Admin on 5/28/19.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit

//Протокол Роутера для окна корзины
protocol BasketRouter: AbstractRouterFactory {
    
    //Указание иинциализации роутера
    init(view: BasketViewController)
    //Функция закрытия данного окна
    func dismiss()
}

//Протокол Роутера для окна корзины
class BasketRouterImplementation: BasketRouter {
    
    fileprivate weak var view: BasketViewController?
    
    required init(view: BasketViewController) {
        self.view = view
    }
    
    public func dismiss() {
        view?.navigationController?.popViewController(animated: true)
    }
    
}
