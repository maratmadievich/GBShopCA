//
//  ProfileViewController.swift
//  GBShop
//
//  Created by Марат Нургалиев on 18/05/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var textFieldUserName: UITextField!
    
    @IBOutlet weak var textFieldPassword: UITextField!
    
    @IBOutlet weak var textFieldEmail: UITextField!
    
    @IBOutlet weak var segmentedControlGender: UISegmentedControl!
    
    @IBOutlet weak var textFieldCard: UITextField!
    
    @IBOutlet weak var textFieldBio: UITextField!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var buttonChangeProfile: UIButton!
    
    
    var presenter: ProfilePresenterProtocol!

    
    override func viewDidLoad() {
       
        super.viewDidLoad()

        configureView()
    }
    
    
    private func configureView() {
        
        presenter = ProfilePresenter(view: self)
        
        activityIndicator.isHidden = true
        
        navigationItem.title = "Профиль"
    }
    
    
    @IBAction func buttonChangeProfileTapped(_ sender: Any) {
        
         presenter.changeProfile(userName: textFieldUserName.text!, password: textFieldPassword.text!, email: textFieldEmail.text!, isGenderMan: segmentedControlGender.selectedSegmentIndex == 0, card: textFieldEmail.text!, bio: textFieldBio.text!)
    }


}

extension ProfileViewController: ProfileView {
    
    func setTextFieldUserName(text: String) {
        
        textFieldUserName.text = text
    }
    
    func setTextFieldPassword(text: String) {
        
        textFieldPassword.text = text
    }
    
    func setTextFieldEmail(text: String) {
        
        textFieldEmail.text = text
    }
    
    func setTextFieldCard(text: String) {
        
        textFieldCard.text = text
    }
    
    func setTextFieldBio(text: String) {
        
        textFieldBio.text = text
    }
    
    func setSengmentedControlGender(selectedItem: Int) {
        
        segmentedControlGender.selectedSegmentIndex = selectedItem
    }
    
    
    func startLoading() {
    
        activityIndicator.startAnimating()
        
        activityIndicator.isHidden = false
    }
    
    func finishLoading() {
        
        activityIndicator.isHidden = true
        
        activityIndicator.stopAnimating()
    }
    
}

extension ProfileViewController: ProtocolShowNetworkAlert {}

extension ProfileViewController: ProtocolShowView {}
