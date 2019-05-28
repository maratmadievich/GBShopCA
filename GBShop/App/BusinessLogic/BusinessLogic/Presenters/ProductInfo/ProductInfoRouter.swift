//
//  ProductInfoRouter.swift
//  GBShop
//
//  Created by Марат Нургалиев on 27/05/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit

protocol ProductInfoRouter: AbstractRouterFactory {
    
    init(view: ProductInfoViewController)
    func dismiss()
}

class ProductInfoRouterImplementation: ProductInfoRouter {
    
    fileprivate weak var view: ProductInfoViewController?
    
    required init(view: ProductInfoViewController) {
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
