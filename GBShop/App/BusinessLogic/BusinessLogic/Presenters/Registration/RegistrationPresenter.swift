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
            
            if model.isRegistrationDataCorrect() {
                
                callRegistrationRequest()
            }
            else {
                
                view?.showError(text: "Одно из полей заполнено неверно")
            }
            
        }
        
    }
    
    
    private func callRegistrationRequest() {
        
        changeLoad(isLoad: true)
        
        let registrationRequest = requestFactory.makeRegistrationRequestFatory()
        
        registrationRequest.registrate(userName: model.userName, password: model.password, email: model.email, gender: model.gender) {
            
            [unowned self] response in
            
            self.changeLoad(isLoad: false)
            
            switch response.result {
                
            case .success(let registrationResponse):
                
                UserSingleton.instance.setUser(user: registrationResponse.user)
                
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
    
    
}

