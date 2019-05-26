//
//  RegistrationModel.swift
//  GBShop
//
//  Created by Admin on 5/17/19.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation

struct RegistrationModel {
    
    var userName: String
    var password: String
    var email: String
    var gender: String
    
    init() {
        userName = ""
        password = ""
        email = ""
        gender = ""
    }
    
    func isRegistrationDataCorrect() -> Bool {
        return userName.count > 0
            && password.count > 0
            && email.count > 0
    }
    
}
