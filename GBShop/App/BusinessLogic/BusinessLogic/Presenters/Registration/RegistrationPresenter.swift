//
//  RegistrationPresenter.swift
//  GBShop
//
//  Created by Admin on 5/17/19.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation

class RegistrationPresenter: RegistrationPresenterProtocol {
    
    weak fileprivate var view: RegistrationView?
    
    private var model: RegistrationModel!
    
    private var isLoad: Bool = false
    
    private let requestFactory = RequestFactory()
    
    
    required init(view: RegistrationView) {
        
        self.view = view
        
        model = RegistrationModel()
    }
    
    func registrate(userName: String, password: String, email: String, isGenderMan: Bool, card: String, bio: String) {
        
        if !isLoad {
            
            model.userName = userName.trimmingCharacters(in: .whitespacesAndNewlines)
            
            model.password = password.trimmingCharacters(in: .whitespacesAndNewlines)
            
            model.email = email.trimmingCharacters(in: .whitespacesAndNewlines)
            
            model.gender = isGenderMan ? "m" : "w"
            
            model.card = card.trimmingCharacters(in: .whitespacesAndNewlines)
            
            model.bio = bio.trimmingCharacters(in: .whitespacesAndNewlines)
            
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
            && model.email.count > 0
            && model.card.count > 0)
    }
    
    
    
    private func tryRegistrate() {
        
        isLoad = true
        
        view?.startLoading()
        
        let registrationRequest = requestFactory.makeRegistrationRequestFatory()
        
        registrationRequest.registrate(userName: model.userName, password: model.password, email: model.email, gender: model.gender, creditCard: model.card, bio: model.bio) {
            
            [unowned self] response in
            
            self.isLoad = false
            
            DispatchQueue.main.async {
                
                self.view?.finishLoading()
            }
            
            switch response.result {
                
            case .success(let registrationResponse):
                
                print(registrationResponse)
                
            case .failure(let error):
                
                print(error.localizedDescription)
            }
            
        }
        
    }
    
    
}

