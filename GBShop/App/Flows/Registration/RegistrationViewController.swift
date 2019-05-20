//
//  RegistrationViewController.swift
//  GBShop
//
//  Created by Admin on 5/17/19.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    @IBOutlet weak var textFieldUserName: UITextField!
    
    @IBOutlet weak var textFieldPassword: UITextField!
    
    @IBOutlet weak var textFieldEmail: UITextField!
    
    @IBOutlet weak var segmentedControlGender: UISegmentedControl!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var buttonRegistration: UIButton!
    
    var presenter: RegistrationPresenterProtocol!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        configureView()
    }
    
    
    private func configureView() {
        
        presenter = RegistrationPresenter(view: self)
        
        activityIndicator.isHidden = true
        
        navigationItem.title = "Регистрация"
    }
    
    
    @IBAction func buttonRegistrationTapped(_ sender: Any) {
        
        presenter.registrate(userName: textFieldUserName.text!, password: textFieldPassword.text!, email: textFieldEmail.text!, isGenderMan: segmentedControlGender.selectedSegmentIndex == 0)
    }
    
    

}

extension RegistrationViewController: RegistrationView {
    
    func startLoading() {
        
        activityIndicator.startAnimating()
        
        activityIndicator.isHidden = false
    }
    
    func finishLoading() {
        
        activityIndicator.isHidden = true
        
        activityIndicator.stopAnimating()
    }
    
}

extension RegistrationViewController: ProtocolShowNetworkAlert {}

extension RegistrationViewController: ProtocolShowView {}
