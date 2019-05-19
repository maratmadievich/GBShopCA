//
//  LoginResult.swift
//  GBShop
//
//  Created by Admin on 4/22/19.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation

struct LoginResult: Codable {

    let result: Int

    let user: User
}

struct User: Codable {

    let id: Int

    let name: String

    let password: String
    
    let email: String
    
    let gender: String
    
    let card: String
    
    let bio: String
    
    enum CodingKeys: String, CodingKey {

        case id = "id_user"

        case name = "user_name"
        
        case password = "password"

        case email = "email"
        
        case gender = "gender"
        
        case card = "credit_card"
        
        case bio = "bio"
    }
    
}
