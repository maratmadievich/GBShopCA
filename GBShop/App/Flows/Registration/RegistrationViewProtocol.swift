//
//  RegistrationViewProtocol.swift
//  GBShop
//
//  Created by Admin on 5/17/19.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation

protocol RegistrationView: NSObjectProtocol {
    
    func startLoading()
    
    func finishLoading()
    
    func showError(text: String)
}
