//
//  RegistrationViewController.swift
//  GBShop
//
//  Created by Admin on 5/17/19.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    @IBOutlet weak var textFieldLogin: UITextField!
    
    @IBOutlet weak var textFieldPassword: UITextField!
    
    @IBOutlet weak var textFieldEmail: UITextField!
    
    @IBOutlet weak var segmentedControlGender: UISegmentedControl!
    
    @IBOutlet weak var textFieldCard: UITextField!
    
    @IBOutlet weak var textFieldBio: UITextField!
    
    @IBOutlet weak var buttonRegistration: UIButton!
    
    
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    
    @IBAction func buttonRegistrationTapped(_ sender: Any) {
        
    }
    
    

}

extension RegistrationViewController: RegistrationView {
    
    func startLoading() {
        
    }
    
    func finishLoading() {
        
    }
    
    func showError(text: String) {
        
    }
    
    
    
}
