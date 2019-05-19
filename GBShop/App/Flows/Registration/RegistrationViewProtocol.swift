//
//  RegistrationViewProtocol.swift
//  GBShop
//
//  Created by Admin on 5/17/19.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation
import UIKit

protocol RegistrationView: NSObjectProtocol {
    
    var presenter: RegistrationPresenterProtocol! {get set}
    
    func startLoading()
    
    func finishLoading()
    
    func showView(viewController: UIViewController)
    
    func showError(text: String)
}
