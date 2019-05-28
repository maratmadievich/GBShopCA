//
//  BasketRouter.swift
//  GBShop
//
//  Created by Admin on 5/28/19.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit

protocol BasketRouter: AbstractRouterFactory {
    
    init(view: BasketViewController)
    func dismiss()
}

class BasketRouterImplementation: BasketRouter {
    
    fileprivate weak var view: BasketViewController?
    
    required init(view: BasketViewController) {
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
