//
//  RegistrationPresenter.swift
//  GBShop
//
//  Created by Admin on 5/17/19.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation
import UIKit

protocol RegistrationPresenter {
    
    var router: RegistrationRouter { get }
    
    init (view: RegistrationView, model: RegistrationModel, router: RegistrationRouter)
    func registrate(userName: String, password: String, email: String, isGenderMan: Bool)
}

class RegistrationPresenterImplementation: RegistrationPresenter {
    
    fileprivate weak var view: RegistrationView?
    private var model: RegistrationModel
    internal var router: RegistrationRouter
    
    private var isLoad: Bool = false
    private let requestFactory = RequestFactory()
    
    //MARK: - Публичные функции
    required init(view: RegistrationView, model: RegistrationModel, router: RegistrationRouter) {
        self.view = view
        self.model = model
        self.router = router
    }
    
    public func registrate(userName: String, password: String, email: String, isGenderMan: Bool) {
        
        if !isLoad {
            model.userName = userName.trimmingCharacters(in: .whitespacesAndNewlines)
            model.password = password.trimmingCharacters(in: .whitespacesAndNewlines)
            model.email = email.trimmingCharacters(in: .whitespacesAndNewlines)
            model.gender = isGenderMan ? "m" : "w"
            
            if model.isRegistrationDataCorrect() {
                callRegistrationRequest()
            } else {
                view?.showError(text: "Одно из полей заполнено неверно")
            }
        }
    }
    
    //MARK: - Закрытые функции
    private func callRegistrationRequest() {
        changeLoad(isLoad: true)
        
        let registrationRequest = requestFactory.makeRegistrationRequestFatory()
        registrationRequest.registrate(userName: model.userName, password: model.password, email: model.email, gender: model.gender) {
            [unowned self] response in
            
            self.changeLoad(isLoad: false)
            switch response.result {
            case .success(let registrationResponse):
                UserSingleton.instance.setUser(user: registrationResponse.user)
                DispatchQueue.main.async { self.handleRegistrationSuccess() }
                
            case .failure(let error):
                DispatchQueue.main.async { self.view?.showError(text: error.localizedDescription) }
            }
        }
    }
    
    private func changeLoad(isLoad: Bool) {
        self.isLoad = isLoad
        isLoad ? view?.startLoading() : view?.finishLoading()
    }
    
    private func handleRegistrationSuccess() {
        router.showCatalogScene()
    }
    
}

