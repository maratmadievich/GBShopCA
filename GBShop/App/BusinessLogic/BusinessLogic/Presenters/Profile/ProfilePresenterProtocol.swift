//
//  ProfilePresenterProtocol.swift
//  GBShop
//
//  Created by Марат Нургалиев on 18/05/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation

protocol ProfilePresenterProtocol {
    
    init (view: ProfileView)
    
    func changeProfile(userName: String, password: String, email: String, isGenderMan: Bool, card: String, bio: String)
    
}
