//
//  ProfileViewProtocol.swift
//  GBShop
//
//  Created by Марат Нургалиев on 18/05/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation

protocol ProfileView: NSObjectProtocol {
    
    var presenter: ProfilePresenter! {get set}
    
    func setTextFieldUserName(text: String)
    func setTextFieldPassword(text: String)
    func setTextFieldEmail(text: String)
    func setTextFieldCard(text: String)
    func setTextFieldBio(text: String)
    func setSengmentedControlGender(selectedItem: Int)
    
    func startLoading()
    func finishLoading()
    func showError(text: String)
    func showSuccess(text: String)
}
