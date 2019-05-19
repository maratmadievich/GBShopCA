//
//  LoginPresenterProtocol.swift
//  GBShop
//
//  Created by Admin on 5/17/19.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation

protocol LoginPresenterProtocol {
    
    init (view: LoginView)
    
    func login(userName: String, password: String)
    
    func registrate()
    
}
