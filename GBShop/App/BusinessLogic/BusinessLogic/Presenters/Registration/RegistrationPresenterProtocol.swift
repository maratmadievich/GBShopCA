//
//  RegistrationPresenterProtocol.swift
//  GBShop
//
//  Created by Admin on 5/17/19.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation

protocol RegistrationPresenterProtocol {
    
    init (view: RegistrationView)
    
    func registrate(userName: String, password: String, email: String, isGenderMan: Bool, card: String, bio: String)
}
