//
//  ProfileRouter.swift
//  GBShop
//
//  Created by Марат Нургалиев on 26/05/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit

protocol ProfileRouter: AbstractRouterFactory {
    
    init(view: ProfileViewController)
    func dismiss()
}

class ProfileRouterImplementation: ProfileRouter {
    
    fileprivate weak var view: ProfileViewController?
    
    required init(view: ProfileViewController) {
        self.view = view
    }
    
    func dismiss() {
        view?.navigationController?.popViewController(animated: true)
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        view?.navigationItem.backBarButtonItem = backItem
    }
}

