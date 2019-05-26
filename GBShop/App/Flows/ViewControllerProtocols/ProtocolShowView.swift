//
//  ProtocolShowView.swift
//  GBShop
//
//  Created by Admin on 5/20/19.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit

protocol ProtocolShowView { }

extension ProtocolShowView where Self: UIViewController {
    
    func showView(viewController: UIViewController) {
        
        navigationController?.pushViewController(viewController, animated: true)
    }
}
