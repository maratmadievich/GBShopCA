//
//  ProfilePresenter.swift
//  GBShop
//
//  Created by Марат Нургалиев on 18/05/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation

protocol ProfilePresenter {
    
    var router: ProfileRouter { get }
    
    init (view: ProfileView, model: ProfileModel, router: ProfileRouter)
    func changeProfile(userName: String, password: String, email: String, isGenderMan: Bool, card: String, bio: String)
}

class ProfilePresenterImplementation: ProfilePresenter {
    
    fileprivate weak var view: ProfileView?
    private var model: ProfileModel
    internal var router: ProfileRouter
    
    private var isLoad: Bool = false
    private let requestFactory = RequestFactory()
    
    private let messageChangeSuccess = "Изменение прошло успешно!"
    private let errorIncorrectFields = "Одно из полей заполнено неверно"
    
    
    required init(view: ProfileView, model: ProfileModel, router: ProfileRouter) {
        self.view = view
        self.model = model
        self.router = router
        showProfileData()
    }
    
    //MARK: - Публичные функции
    public func changeProfile(userName: String, password: String, email: String, isGenderMan: Bool, card: String, bio: String) {
        
        if !isLoad {
            model.userName = userName.trimmingCharacters(in: .whitespacesAndNewlines)
            model.password = password.trimmingCharacters(in: .whitespacesAndNewlines)
            model.email = email.trimmingCharacters(in: .whitespacesAndNewlines)
            model.gender = isGenderMan ? "m" : "w"
            model.card = card.trimmingCharacters(in: .whitespacesAndNewlines)
            model.bio = bio.trimmingCharacters(in: .whitespacesAndNewlines)

            if model.isProfileDataCorrect() {
                callChangeProfileRequest()
            } else {
                if let view = view {
                    view.showError(text: errorIncorrectFields)
                }
            }
        }
    }
    
    //MARK: - Закрытые функции
    private func callChangeProfileRequest() {
        changeLoad(isLoad: true)
        
        let changeProfileRequest = requestFactory.makeChangeProfileRequestFatory()
        changeProfileRequest.changeProfile(idUser: UserSingleton.instance.getUser().id, userName: model.userName, password: model.password, email: model.email, gender: model.gender, creditCard: model.card, bio: model.bio) {
            [unowned self] response in
            
            self.changeLoad(isLoad: false)
            switch response.result {
            case .success(let changeProfileResponse):
                UserSingleton.instance.setUser(user: changeProfileResponse.user)
                DispatchQueue.main.async {
                    if let view = self.view {
                        view.showSuccess(text: self.messageChangeSuccess)
                    }
                }
                
            case .failure(let error):
                DispatchQueue.main.async {
                    if let view = self.view {
                        view.showError(text: error.localizedDescription)
                    }
                }
            }
        }
    }
    
    private func showProfileData() {
        guard let view = view else {
            return
        }
        view.setTextFieldUserName(text: UserSingleton.instance.getUser().name)
        view.setTextFieldPassword(text: UserSingleton.instance.getUser().password)
        view.setTextFieldEmail(text: UserSingleton.instance.getUser().email)
        view.setTextFieldCard(text: UserSingleton.instance.getUser().card)
        view.setTextFieldBio(text: UserSingleton.instance.getUser().bio)
        view.setSengmentedControlGender(selectedItem: UserSingleton.instance.getUser().gender == "m" ? 0 : 1)
    }
    
    private func changeLoad(isLoad: Bool) {
        self.isLoad = isLoad
        if let view = view {
            isLoad ? view.startLoading() : view.finishLoading()
        }
    }
    
}

