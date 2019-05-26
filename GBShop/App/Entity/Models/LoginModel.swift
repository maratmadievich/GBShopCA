//
//  LoginModel.swift
//  GBShop
//
//  Created by Admin on 5/17/19.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation

struct LoginModel {
    
    var userName: String
    var password: String
    
    
    init() {
        userName = ""
        password = ""
    }
    
    func isLoginDataCorrect() -> Bool {
        return userName.count > 0 && password.count > 0
    }
    
}
