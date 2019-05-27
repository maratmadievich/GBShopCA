//
//  CatalogRouter.swift
//  GBShop
//
//  Created by Марат Нургалиев on 26/05/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit

protocol CatalogRouter: AbstractRouterFactory {
    
    init(view: CatalogViewController)
    func showProfileScene()
    func showProductInfoScene(product: Product)
}

class CatalogRouterImplementation: CatalogRouter {
    
    fileprivate weak var view: CatalogViewController?
    private var product: Product!
    
    required init(view: CatalogViewController) {
        self.view = view
    }
    
    public func showProfileScene() {
        view?.performSegue(withIdentifier: "showProfileScene", sender: nil)
    }
    
    public func showProductInfoScene(product: Product) {
        self.product = product
        view?.performSegue(withIdentifier: "showProductInfoScene", sender: nil)
    }
    
    public func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let productInfoController = segue.destination as? ProductInfoViewController {
            productInfoController.configurator = ProductInfoConfiguratorImplementation()
            productInfoController.configurator
                .configure(productInfoController: productInfoController, product: product)
        }
        let backItem = UIBarButtonItem()
        backItem.title = ""
        view?.navigationItem.backBarButtonItem = backItem
    }
}
