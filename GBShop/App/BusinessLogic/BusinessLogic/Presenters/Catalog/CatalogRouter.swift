//
//  CatalogRouter.swift
//  GBShop
//
//  Created by Марат Нургалиев on 26/05/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit

//Протокол Роутера для окна списка товаров
protocol CatalogRouter: AbstractRouterFactory {
    
    //Указание иинциализации роутера
    init(view: CatalogViewController)
    //Функция для перехода к окну Корзина
    func showBasketScene()
    //Функция для перехода к окну Профиль
    func showProfileScene()
    //Функция для перехода к окну Информация о продукте
    func showProductInfoScene(product: Product)
}

//Протокол Роутера для окна списка товаров
class CatalogRouterImplementation: CatalogRouter {
    
    fileprivate weak var view: CatalogViewController?
    private var product: Product!
    
    required init(view: CatalogViewController) {
        self.view = view
    }
    
    public func showBasketScene() {
        view?.performSegue(withIdentifier: "showBasketScene", sender: nil)
    }
    
    public func showProfileScene() {
        view?.performSegue(withIdentifier: "showProfileScene", sender: nil)
    }
    
    //Данная функция сохраняет продукт, информацию о котором нужно показать и осуществляет переход
    public func showProductInfoScene(product: Product) {
        self.product = product
        view?.performSegue(withIdentifier: "showProductInfoScene", sender: nil)
    }
    
    //Функция для настройки открываяющихся контроллеров перед самим переходом
    //Если окно = ProductInfoViewController, то
    //необходимо вызвать конфигурацию окна на основе
    //выбранного продукта
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
