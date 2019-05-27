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

protocol LoginPresenter {
    
    var router: LoginRouter { get }
    
    init (view: LoginView, model: LoginModel, router: LoginRouter)
    func login(userName: String, password: String)
    func registrate()
}

class LoginPresenterImplementation: LoginPresenter {
    
    fileprivate weak var view: LoginView?
    private var model: LoginModel
    internal let router: LoginRouter
    
    private var isLoad: Bool = false
    private let requestFactory = RequestFactory()
    
    private let errorEmptyFields = "Не все поля заполнены"
    private let errorIncorrectFields = "Одно из полей заполнено неверно"
    
    
    //MARK: - Публичные функции
    required init(view: LoginView, model: LoginModel, router: LoginRouter) {
        self.view = view
        self.model = model
        self.router = router
    }
    
    public func login(userName: String, password: String) {
        if !isLoad {
            guard let view = view else {
                return
            }
            if userName.count == 0 || password.count == 0 {
                view.showError(text: errorEmptyFields)
                return
            }
            
            model.userName = userName.trimmingCharacters(in: .whitespacesAndNewlines)
            model.password = password.trimmingCharacters(in: .whitespacesAndNewlines)
            if model.isLoginDataCorrect() {
                callLoginRequest()
            } else {
                view.showError(text: errorIncorrectFields)
            }
        }
    }
    
    public func registrate() {
        router.showRegistrateScene()
    }
    
    //MARK: - Закрытые функции
    private func callLoginRequest() {
        changeLoad(isLoad: true)
        let loginRequest = requestFactory.makeLoginRequestFactory()
        loginRequest.login(userName: model.userName, password: model.password) {
            
            [unowned self] response in
            self.changeLoad(isLoad: false)
            
            switch response.result {
            case .success(let loginResponce):
                UserSingleton.instance.setUser(user: loginResponce.user)
                DispatchQueue.main.async { self.handleLoginSuccess() }
                
            case .failure(let error):
                DispatchQueue.main.async {
                    if let view = self.view {
                        view.showError(text: error.localizedDescription)
                    }
                }
            }
        }
    }
    
    private func changeLoad(isLoad: Bool) {
        self.isLoad = isLoad
        if let view = view {
            isLoad ? view.startLoading() : view.finishLoading()
        }
    }
    
    private func handleLoginSuccess() {
        router.showCatalogScene()
    }
    
}
