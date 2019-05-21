//
//  ProfilePresenter.swift
//  GBShop
//
//  Created by Марат Нургалиев on 18/05/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation

class ProfilePresenter: ProfilePresenterProtocol {
    
    weak fileprivate var view: ProfileView?
    
    private var model: ProfileModel!
    
    private var isLoad: Bool = false
    
    private let requestFactory = RequestFactory()
    
    private let messageChangeSuccess = "Изменение прошло успешно!"
    
    private let errorIncorrectFields = "Одно из полей заполнено неверно"
    
    
    required init(view: ProfileView) {
        
        self.view = view
        
        showProfileData()
        
        model = ProfileModel()
    }
    
    
    private func showProfileData() {
        
        view?.setTextFieldUserName(text: UserSingleton.instance.getUser().name)
        
        view?.setTextFieldPassword(text: UserSingleton.instance.getUser().password)
        
        view?.setTextFieldEmail(text: UserSingleton.instance.getUser().email)
        
        view?.setTextFieldCard(text: UserSingleton.instance.getUser().card)
        
        view?.setTextFieldBio(text: UserSingleton.instance.getUser().bio)
        
        view?.setSengmentedControlGender(selectedItem: UserSingleton.instance.getUser().gender == "m" ? 0 : 1)
    }
    
    
    func changeProfile(userName: String, password: String, email: String, isGenderMan: Bool, card: String, bio: String) {
        
        if !isLoad {
            
            model.userName = userName.trimmingCharacters(in: .whitespacesAndNewlines)

            model.password = password.trimmingCharacters(in: .whitespacesAndNewlines)

            model.email = email.trimmingCharacters(in: .whitespacesAndNewlines)

            model.gender = isGenderMan ? "m" : "w"

            model.card = card.trimmingCharacters(in: .whitespacesAndNewlines)

            model.bio = bio.trimmingCharacters(in: .whitespacesAndNewlines)

            if model.isProfileDataCorrect() {

                callChangeProfileRequest()
            }
            else {

                view?.showError(text: errorIncorrectFields)
            }
            
        }
        
    }
    
    
    private func callChangeProfileRequest() {
        
        changeLoad(isLoad: true)
        
        let changeProfileRequest = requestFactory.makeChangeProfileRequestFatory()
        
        changeProfileRequest.changeProfile(idUser: UserSingleton.instance.getUser().id, userName: model.userName, password: model.password, email: model.email, gender: model.gender, creditCard: model.card, bio: model.bio) {
            
            [unowned self] response in
            
            self.changeLoad(isLoad: false)
            
            switch response.result {
                
            case .success(let changeProfileResponse):
                
                UserSingleton.instance.setUser(user: changeProfileResponse.user)
                
                DispatchQueue.main.async { self.view?.showSuccess(text: self.messageChangeSuccess) }
                
            case .failure(let error):
                
                DispatchQueue.main.async {self.view?.showError(text: error.localizedDescription) }
            }
            
        }
        
    }
    
    
    private func changeLoad(isLoad: Bool) {
        
        self.isLoad = isLoad
        
        isLoad ? view?.startLoading() : view?.finishLoading()
    }
    
    
}

