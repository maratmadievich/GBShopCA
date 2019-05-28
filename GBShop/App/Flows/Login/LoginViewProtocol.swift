//
//  LoginViewProtocol.swift
//  GBShop
//
//  Created by Admin on 5/17/19.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation
import UIKit

protocol LoginView: NSObjectProtocol {
    
    var presenter: LoginPresenter! {get set}
    
    func startLoading()
    func finishLoading()
    func showError(text: String)
}
