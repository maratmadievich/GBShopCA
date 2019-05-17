//
//  LoginViewProtocol.swift
//  GBShop
//
//  Created by Admin on 5/17/19.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation

protocol LoginView: NSObjectProtocol {
    
    func startLoading()
    
    func finishLoading()
    
    func showRegistrationView()
    
    func showError(text: String)
}
