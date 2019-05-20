//
//  UserSingleton.swift
//  GBShop
//
//  Created by Admin on 5/20/19.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation

class UserSingleton {
    
    static let instance = UserSingleton()
    
    private static var user: User!
    
    
    private init(){}
    
    
    func getUser() -> User {
     
        return UserSingleton.user
    }
    
    func setUser(user: User) {
        
        UserSingleton.user = user
    }
}
