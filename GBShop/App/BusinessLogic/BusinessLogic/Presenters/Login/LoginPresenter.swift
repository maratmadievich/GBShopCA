//
//  LoginPresenter.swift
//  GBShop
//
//  Created by Admin on 5/17/19.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit
import Answers

/// Описывает Пресентер для окна авторизации
internal protocol LoginPresenter {
    
    /// Указывает наличие роутера для переходов из окна авторизации
    var router: LoginRouter { get }
    
    /// Описание необходимой инициализации
    /// Параметры:
    /// - view: объект, имеющий расширение LoginView для реализации модели MVP
    /// - model: модель для реализации модели MVP
    /// - router: объект, имеющий расширение LoginRouter для реализации переходов
    init (view: LoginView, model: LoginModel, router: LoginRouter)
    
    /// Осуществляет передачу данных для авторизации
    /// Параметры:
    /// - userName: логин пользователя
    /// - password: пароль пользователя
    func login(userName: String, password: String)
    
    /// Осуществляет переход к окну Авторизация
    func showRegistrate()
}

/// Реализует Пресентер для окна авторизации
internal class LoginPresenterImplementation: LoginPresenter {
    
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
    
    /// Производит проверку введенных данных
    /// В случае некоррекстных данных выводит ошибки на экран
    /// Иначе вызывает метод авторизации
    public func login(userName: String, password: String) {
        if !isLoad {
            if userName.count == 0 || password.count == 0 {
                handleError(error: errorEmptyFields)
                return
            }
            model.userName = userName.trimmingCharacters(in: .whitespacesAndNewlines)
            model.password = password.trimmingCharacters(in: .whitespacesAndNewlines)
            if model.isLoginDataCorrect() {
                callLoginRequest()
            } else {
                handleError(error: errorIncorrectFields)
            }
        }
    }
    
    public func showRegistrate() {
        router.showRegistrateScene()
    }
    
    //MARK: - Закрытые функции
    
    /// Вызывает API-meтод авторизации
    private func callLoginRequest() {
        changeLoad(isLoad: true)
        let loginRequest = requestFactory.makeLoginRequestFactory()
        loginRequest.login(userName: model.userName, password: model.password) {
            [unowned self] response in
            
            self.changeLoad(isLoad: false)
            switch response.result {
            case .success(let loginResponce):
                UserSingleton.instance.setUser(user: loginResponce.user)
                self.handleLoginSuccess()
                
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
    
    /// Вызывает метод для перехода к экрану Списка товаров
    private func handleLoginSuccess() {
        Analytic.instance.sendEvent(method: .login, parameters: ["login": model.userName, "password": model.password])
        DispatchQueue.main.async {
            self.router.showCatalogScene()
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
