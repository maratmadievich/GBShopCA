//
//  LoginViewController.swift
//  GBShop
//
//  Created by Admin on 5/17/19.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var textFieldLogin: UITextField!
    
    @IBOutlet weak var textFieldPassword: UITextField!
    
    @IBOutlet weak var buttonLogin: UIButton!
    
    @IBOutlet weak var buttonRegistration: UIButton!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var presenter: LoginPresenterProtocol!
    
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        configureView()
    }
    
    
    private func configureView() {
        
        presenter = LoginPresenter(view: self)
        
        activityIndicator.isHidden = true
    }
    

    @IBAction func buttonLoginTapped(_ sender: Any) {
        
        presenter.login(userName: textFieldLogin.text!, password: textFieldPassword.text!)
    }
    
    
    @IBAction func buttonRegistrationTapped(_ sender: Any) {
    
        presenter.registrate()
    }
    
}

extension LoginViewController: LoginView {
    
    func startLoading() {
        
        activityIndicator.startAnimating()
        
        activityIndicator.isHidden = false
    }
    
    func finishLoading() {
        
        activityIndicator.isHidden = true
        
        activityIndicator.stopAnimating()
    }
    
}

extension LoginViewController: ProtocolShowNetworkAlert {}

extension LoginViewController: ProtocolShowView {}
