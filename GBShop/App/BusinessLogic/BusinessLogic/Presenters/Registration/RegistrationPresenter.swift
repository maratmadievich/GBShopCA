//
//  RegistrationPresenter.swift
//  GBShop
//
//  Created by Admin on 5/17/19.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation
import UIKit

/// Описывает Пресентер для окна регистрации
internal protocol RegistrationPresenter {
    
    /// Указывает наличие роутера для переходов из окна регистрации
    var router: RegistrationRouter { get }
    
    /// Описание необходимой инициализации
    /// Параметры:
    /// - view: объект, имеющий расширение RegistrationView для реализации модели MVP
    /// - model: модель для реализации модели MVP
    /// - router: объект, имеющий расширение RegistrationRouter для реализации переходов
    init (view: RegistrationView, model: RegistrationModel, router: RegistrationRouter)
    
    /// Осуществляет передачу данных для регистрации
    /// Параметры:
    /// - userName: логин пользователя
    /// - password: пароль пользователя
    /// - email: email пользователя
    /// - isGenderMan: пол пользователя, где
    /// true - мужчина, false - женщина
    func registrate(userName: String, password: String, email: String, isGenderMan: Bool)
}

//реализация Пресентера для окна регистрации
internal class RegistrationPresenterImplementation: RegistrationPresenter {
    
    fileprivate weak var view: RegistrationView?
    private var model: RegistrationModel
    internal var router: RegistrationRouter
    
    private var isLoad: Bool = false
    private let requestFactory = RequestFactory()
    private let errorIncorrectFields = "Одно из полей заполнено неверно"
    
    //MARK: - Публичные функции
    required init(view: RegistrationView, model: RegistrationModel, router: RegistrationRouter) {
        self.view = view
        self.model = model
        self.router = router
    }
    
    /// Производит проверку введенных данных
    /// В случае некоррекстных данных выводит ошибки на экран
    /// Иначе вызывает метод регистрации
    public func registrate(userName: String, password: String, email: String, isGenderMan: Bool) {
        
        if !isLoad {
            model.userName = userName.trimmingCharacters(in: .whitespacesAndNewlines)
            model.password = password.trimmingCharacters(in: .whitespacesAndNewlines)
            model.email = email.trimmingCharacters(in: .whitespacesAndNewlines)
            model.gender = isGenderMan ? "m" : "w"
            model.isRegistrationDataCorrect() ? callRegistrationRequest() : handleError(error: errorIncorrectFields)
        }
    }
    
    //MARK: - Закрытые функции
    
    /// Вызывает API-meтод регистрации
    private func callRegistrationRequest() {
        changeLoad(isLoad: true)
        
        let registrationRequest = requestFactory.makeRegistrationRequestFatory()
        registrationRequest.registrate(userName: model.userName, password: model.password, email: model.email, gender: model.gender) {
            [unowned self] response in
            
            self.changeLoad(isLoad: false)
            switch response.result {
            case .success(let registrationResponse):
                UserSingleton.instance.setUser(user: registrationResponse.user)
                self.handleRegistrationSuccess()
                
            case .failure(let error):
                self.handleError(error: error.localizedDescription)
            }
        }
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
    
     /// Осуществляет переход в окно Список товаров
    private func handleRegistrationSuccess() {
        Analytic.instance.sendEvent(method: .registration, parameters: ["login": model.userName,
                                                                        "password": model.password,
                                                                        "gender": model.gender,
                                                                        "email": model.email])
        DispatchQueue.main.async {
            self.router.showCatalogScene()
        }
    }
    
    /// Отображает ошибки на экране
    private func handleError(error: String) {
        Analytic.instance.assertionFailure(method: .registration, message: error)
        if let view = view {
            DispatchQueue.main.async {
                view.showError(text: error)
            }
        }
    }
    
}

