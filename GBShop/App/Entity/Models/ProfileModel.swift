//
//  ProfileModel.swift
//  GBShop
//
//  Created by Марат Нургалиев on 19/05/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation

struct ProfileModel {
    
    var userName: String
    var password: String
    var email: String
    var gender: String
    var card: String
    var bio: String
    
    init() {
        userName = ""
        password = ""
        email = ""
        gender = ""
        card = ""
        bio = ""
    }
    
    func isProfileDataCorrect() -> Bool {
        return userName.count > 0
            && password.count > 0
            && email.count > 0
    }
    
}
