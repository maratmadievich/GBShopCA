//
//  LoginPresenter.swift
//  GBShop
//
//  Created by Admin on 5/17/19.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation
import UIKit

class LoginPresenter: LoginPresenterProtocol {
    
    weak fileprivate var view: LoginView?
    
    private var model: LoginModel!
    
    private var isLoad: Bool = false
    
    private let requestFactory = RequestFactory()
    
    
    required init(view: LoginView) {
        
        self.view = view
        
        model = LoginModel()
    }
    
    
    func login(userName: String, password: String) {
        
        if !isLoad {
            
            model.userName = userName.trimmingCharacters(in: .whitespacesAndNewlines)
            
            model.password = password.trimmingCharacters(in: .whitespacesAndNewlines)
            
            if model.userName.count > 0 && model.password.count > 0 {
                
                tryLogin()
            }
            else if userName.count > 0 && password.count > 0 {
                
                view?.showError(text: "Не все поля заполнены")
            }
            else {
                
                view?.showError(text: "Одно из полей заполнено неверно")
            }
            
        }
        
    }
    
    
    func registrate() {
        
        showRegistrationView()
    }
    
    
    private func tryLogin() {
        
        isLoad = true
        
        view?.startLoading()
        
        let loginRequest = requestFactory.makeLoginRequestFactory()
        
        loginRequest.login(userName: model.userName, password: model.password) {
            
            [unowned self] response in
            
            self.isLoad = false
            
            DispatchQueue.main.async {
                
                self.view?.finishLoading()
                
                switch response.result {
                    
                case .success(let loginResponce):
                    
                    print(loginResponce)
                    
                    UserSingleton.instance.setUser(user: loginResponce.user)
                    
                    self.showProfileView()
                    
                case .failure(let error): 
                        
                    self.view?.showError(text: error.localizedDescription)
                }
                
            }
            
        }
        
    }
    
    
    private func showProfileView() {
        
        let storyboard = UIStoryboard(name: "Profile", bundle: nil)
        
        let viewController = storyboard.instantiateViewController(withIdentifier: "Profile") as! ProfileViewController
        
        view?.showView(viewController: viewController)
    }
    
    
    private func showRegistrationView() {
        
        let storyboard = UIStoryboard(name: "Registration", bundle: nil)
        
        let viewController = storyboard.instantiateViewController(withIdentifier: "Registration") as! RegistrationViewController
        
        view?.showView(viewController: viewController)
    }
    
    
}
