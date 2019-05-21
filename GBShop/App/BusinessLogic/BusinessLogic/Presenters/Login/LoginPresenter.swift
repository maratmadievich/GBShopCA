//
//  LoginPresenter.swift
//  GBShop
//
//  Created by Admin on 5/17/19.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class LoginPresenter: LoginPresenterProtocol {
    
    weak fileprivate var view: LoginView?
    
    private var model: LoginModel!
    
    private var isLoad: Bool = false
    
    private let requestFactory = RequestFactory()
    
    private let errorEmptyFields = "Не все поля заполнены"
    
    private let errorIncorrectFields = "Одно из полей заполнено неверно"
    
    
    required init(view: LoginView) {
        
        self.view = view
        
        model = LoginModel()
    }
    
    
    func login(userName: String, password: String) {
        
        if !isLoad {
            
            if userName.count == 0 || password.count == 0 {
                
                view?.showError(text: errorEmptyFields)
                
                return
            }
            
            model.userName = userName.trimmingCharacters(in: .whitespacesAndNewlines)
            
            model.password = password.trimmingCharacters(in: .whitespacesAndNewlines)
            
            if model.isLoginDataCorrect() {
                
                callLoginRequest()
            }
            else {
                
                view?.showError(text: errorIncorrectFields)
            }
            
        }
        
    }
    
    
    func registrate() {
        
        showRegistrationView()
    }
    
    
    private func callLoginRequest() {
        
        changeLoad(isLoad: true)
        
        let loginRequest = requestFactory.makeLoginRequestFactory()
        
        loginRequest.login(userName: model.userName, password: model.password) {
            
            [unowned self] response in
            
            self.changeLoad(isLoad: false)
            
            switch response.result {
                
            case .success(let loginResponce):
                
                UserSingleton.instance.setUser(user: loginResponce.user)
                
                DispatchQueue.main.async { self.showCatalogView() }
                
            case .failure(let error):
                
                DispatchQueue.main.async { self.view?.showError(text: error.localizedDescription) }
            }
            
        }
        
    }
    
    
    private func changeLoad(isLoad: Bool) {
        
        self.isLoad = isLoad
        
        isLoad ? view?.startLoading() : view?.finishLoading()
    }
    
    
    private func showCatalogView() {
        
        let storyboard = UIStoryboard(name: "Catalog", bundle: nil)
        
        let viewController = storyboard.instantiateViewController(withIdentifier: "Catalog") as! CatalogViewController
        
        view?.showView(viewController: viewController)
    }
    
    
    private func showRegistrationView() {
        
        let storyboard = UIStoryboard(name: "Registration", bundle: nil)
        
        let viewController = storyboard.instantiateViewController(withIdentifier: "Registration") as! RegistrationViewController
        
        view?.showView(viewController: viewController)
    }
    
    
}
