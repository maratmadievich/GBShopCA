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

            if !haveEmptyFields() {

                tryChangeProfile()
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
    
    
    
    private func tryChangeProfile() {
        
        isLoad = true
        
        view?.startLoading()
        
        let changeProfileRequest = requestFactory.makeChangeProfileRequestFatory()
        
        changeProfileRequest.changeProfile(idUser: UserSingleton.instance.getUser().id, userName: model.userName, password: model.password, email: model.email, gender: model.gender, creditCard: model.card, bio: model.bio) {
            
            [unowned self] response in
            
            DispatchQueue.main.async {
                
                self.isLoad = false
                
                self.view?.finishLoading()
                
                
                switch response.result {
                    
                case .success(let changeProfileResponse):
                    
                    print(changeProfileResponse)
                    
                    UserSingleton.instance.setUser(user: changeProfileResponse.user)
                    
                    self.view?.showSuccess(text: "Изменение прошло успешно!")
                    
                case .failure(let error):
                        
                    self.view?.showError(text: error.localizedDescription)
                    
                }
                
            }
            
        }
        
    }
    
    
}

