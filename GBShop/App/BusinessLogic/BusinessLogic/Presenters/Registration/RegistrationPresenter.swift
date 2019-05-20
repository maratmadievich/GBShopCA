//
//  RegistrationPresenter.swift
//  GBShop
//
//  Created by Admin on 5/17/19.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation
import UIKit

class RegistrationPresenter: RegistrationPresenterProtocol {
    
    weak fileprivate var view: RegistrationView?
    
    private var model: RegistrationModel!
    
    private var isLoad: Bool = false
    
    private let requestFactory = RequestFactory()
    
    
    required init(view: RegistrationView) {
        
        self.view = view
        
        model = RegistrationModel()
    }
    
    
    func registrate(userName: String, password: String, email: String, isGenderMan: Bool) {
        
        if !isLoad {
            
            model.userName = userName.trimmingCharacters(in: .whitespacesAndNewlines)
            
            model.password = password.trimmingCharacters(in: .whitespacesAndNewlines)
            
            model.email = email.trimmingCharacters(in: .whitespacesAndNewlines)
            
            model.gender = isGenderMan ? "m" : "w"
            
            if !haveEmptyFields() {
                
                tryRegistrate()
            }
            else {
                
                view?.showError(text: "Одно из полей заполнено неверно")
            }
            
        }
        
    }
    
    
    private func haveEmptyFields() -> Bool {
        
        return !(model.userName.count > 0
            && model.password.count > 0
            && model.email.count > 0)
    }
    
    
    
    private func tryRegistrate() {
        
        isLoad = true
        
        view?.startLoading()
        
        let registrationRequest = requestFactory.makeRegistrationRequestFatory()
        
        registrationRequest.registrate(userName: model.userName, password: model.password, email: model.email, gender: model.gender) {
            
            [unowned self] response in
            
            DispatchQueue.main.async {
                
                self.isLoad = false
                
                self.view?.finishLoading()
                
                switch response.result {
                    
                case .success(let registrationResponse):
                    
                    print(registrationResponse)
                    
                    UserSingleton.instance.setUser(user: registrationResponse.user)
                    
                    self.showCatalogView()
                    
                case .failure(let error):
                    
                    DispatchQueue.main.async {
                        
                        self.view?.showError(text: error.localizedDescription)
                    }
                    
                }
                
            }
            
        }
        
    }
        
        
    private func showCatalogView() {
        
        let storyboard = UIStoryboard(name: "Catalog", bundle: nil)
        
        let viewController = storyboard.instantiateViewController(withIdentifier: "Catalog") as! CatalogViewController
        
        view?.showView(viewController: viewController)
    }
    
    
}

