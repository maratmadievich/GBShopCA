//
//  AlertExtension.swift
//  GBShop
//
//  Created by Admin on 5/20/19.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit

protocol ProtocolShowNetworkAlert { }

extension ProtocolShowNetworkAlert where Self: UIViewController {
    
    func showError(text: String) {
        
        let alert = UIAlertController(title: "Ошибка", message: text, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Хорошо", style: .default, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    
    func showSuccess(text: String) {
        
        let alert = UIAlertController(title: "Изменение профиля", message: text, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Хорошо", style: .default, handler: nil))
        
        self.present(alert, animated: true)
    }
    
}
