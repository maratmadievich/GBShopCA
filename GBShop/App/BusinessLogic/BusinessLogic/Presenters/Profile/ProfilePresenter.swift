//
//  ProfilePresenter.swift
//  GBShop
//
//  Created by Марат Нургалиев on 18/05/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation

//Протокол Пресентера для окна смены профиля
protocol ProfilePresenter {
    
    //Указание наличия роутера для переходов из окна смены профиля
    var router: ProfileRouter { get }
    
    //Указание инициализации пресентера
    init (view: ProfileView, model: ProfileModel, router: ProfileRouter)
    //Функция для передачи введеных данных для смены профиля
    func changeProfile(userName: String, password: String, email: String, isGenderMan: Bool, card: String, bio: String)
}

//реализация Пресентера для окна смены профиля
class ProfilePresenterImplementation: ProfilePresenter {
    
    fileprivate weak var view: ProfileView?
    private var model: ProfileModel
    internal var router: ProfileRouter
    
    private var isLoad: Bool = false
    private let requestFactory = RequestFactory()
    
    private let messageChangeTitle = "Изменение профиля"
    private let messageChangeSuccess = "Изменение прошло успешно!"
    private let errorIncorrectFields = "Одно из полей заполнено неверно"
    
    //MARK: - Публичные функции
    required init(view: ProfileView, model: ProfileModel, router: ProfileRouter) {
        self.view = view
        self.model = model
        self.router = router
        showProfileData()
    }
    
    //В данной функции производится проверка полученных данных
    //Если данные коррекны, вызывается метод смены профиля
    //иначе выводится ошибка
    public func changeProfile(userName: String, password: String, email: String, isGenderMan: Bool, card: String, bio: String) {
        
        if !isLoad {
            model.userName = userName.trimmingCharacters(in: .whitespacesAndNewlines)
            model.password = password.trimmingCharacters(in: .whitespacesAndNewlines)
            model.email = email.trimmingCharacters(in: .whitespacesAndNewlines)
            model.gender = isGenderMan ? "m" : "w"
            model.card = card.trimmingCharacters(in: .whitespacesAndNewlines)
            model.bio = bio.trimmingCharacters(in: .whitespacesAndNewlines)

            model.isProfileDataCorrect() ? callChangeProfileRequest() : handleError(error: errorIncorrectFields)
        }
    }
    
    //MARK: - Закрытые функции
    //В данной функции происходит попытка смены профиля
    //При успешной регистрации записывает данные
    //иначе выводится ошибка
    private func callChangeProfileRequest() {
        changeLoad(isLoad: true)
        
        let changeProfileRequest = requestFactory.makeChangeProfileRequestFatory()
        changeProfileRequest.changeProfile(idUser: UserSingleton.instance.getUser().id, userName: model.userName, password: model.password, email: model.email, gender: model.gender, creditCard: model.card, bio: model.bio) {
            [unowned self] response in
            
            self.changeLoad(isLoad: false)
            switch response.result {
            case .success(let changeProfileResponse):
                UserSingleton.instance.setUser(user: changeProfileResponse.user)
                self.handleChangeProfileSuccess()
                
            case .failure(let error):
                self.handleError(error: error.localizedDescription)
            }
        }
    }
    
    //Функция для отображения текущих данных пользователя
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
    
    /// Меняет состояние загрузки данных на экране
    private func changeLoad(isLoad: Bool) {
        self.isLoad = isLoad
        if let view = view {
            DispatchQueue.main.async {
                isLoad ? view.startLoading() : view.finishLoading()
            }
        }
    }
    
    /// Вызывает метод для отображения успешной смены информации о профиле
    private func handleChangeProfileSuccess() {
        Analytic.instance.sendEvent(method: .profile, parameters: ["login": model.userName,
                                                                   "password": model.password,
                                                                   "email": model.email,
                                                                   "gender": model.gender,
                                                                   "card": model.card,
                                                                   "bio": model.bio])
        if let view = view {
            DispatchQueue.main.async {
                view.showSuccess(title: self.messageChangeTitle, text: self.messageChangeSuccess)
            }
        }
    }
    
    /// Отображает ошибки на экране
    private func handleError(error: String) {
        Analytic.instance.assertionFailure(method: .login, message: error)
        if let view = view {
            DispatchQueue.main.async {
                view.showError(text: error)
            }
        }
    }

    
}

