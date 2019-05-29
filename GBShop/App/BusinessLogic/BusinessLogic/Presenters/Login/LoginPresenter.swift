//
//  LoginPresenter.swift
//  GBShop
//
//  Created by Admin on 5/17/19.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation
import UIKit

//Протокол Пресентера для окна авторизации
protocol LoginPresenter {
    
    //Указание наличия роутера для переходов из окна авторизации
    var router: LoginRouter { get }
    
    //Указание инициализации пресентера
    init (view: LoginView, model: LoginModel, router: LoginRouter)
    //Функция для передачи введеных логина и пароля для авторизации
    func login(userName: String, password: String)
    //Функция для перехода к окну регистрации
    func registrate()
}

//реализация Пресентера для окна авторизации
class LoginPresenterImplementation: LoginPresenter {
    
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
    
    //В данной функции производится проверка полученных данных
    //Если данные коррекны, вызывается метод авторизации
    //иначе выводится ошибка
    public func login(userName: String, password: String) {
        if !isLoad {
            guard let view = view else {
                return
            }
            if userName.count == 0 || password.count == 0 {
                view.showError(text: errorEmptyFields)
                return
            }
            
            model.userName = userName.trimmingCharacters(in: .whitespacesAndNewlines)
            model.password = password.trimmingCharacters(in: .whitespacesAndNewlines)
            if model.isLoginDataCorrect() {
                callLoginRequest()
            } else {
                view.showError(text: errorIncorrectFields)
            }
        }
    }
    
    public func registrate() {
        router.showRegistrateScene()
    }
    
    //MARK: - Закрытые функции
    //В данной функции происходит попытка авторизации
    //При успешной авторизации записывает данные
    //иначе выводится ошибка
    private func callLoginRequest() {
        changeLoad(isLoad: true)
        let loginRequest = requestFactory.makeLoginRequestFactory()
        loginRequest.login(userName: model.userName, password: model.password) {
            
            [unowned self] response in
            self.changeLoad(isLoad: false)
            
            switch response.result {
            case .success(let loginResponce):
                UserSingleton.instance.setUser(user: loginResponce.user)
                DispatchQueue.main.async { self.handleLoginSuccess() }
                
            case .failure(let error):
                DispatchQueue.main.async {
                    if let view = self.view {
                        view.showError(text: error.localizedDescription)
                    }
                }
            }
        }
    }
    
    //Функция для смены состояния загрузки
    private func changeLoad(isLoad: Bool) {
        self.isLoad = isLoad
        if let view = view {
            isLoad ? view.startLoading() : view.finishLoading()
        }
    }
    
    //Функция, в которой происходят действия
    //после успешной авторизации
    private func handleLoginSuccess() {
        router.showCatalogScene()
    }
    
}
