//
//  RegistrationPresenter.swift
//  GBShop
//
//  Created by Admin on 5/17/19.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation
import UIKit

//Протокол Пресентера для окна регистрации
protocol RegistrationPresenter {
    
    //Указание наличия роутера для переходов из окна регистрации
    var router: RegistrationRouter { get }
    
    //Указание инициализации пресентера
    init (view: RegistrationView, model: RegistrationModel, router: RegistrationRouter)
    //Функция для передачи введеных данных для регистрации
    func registrate(userName: String, password: String, email: String, isGenderMan: Bool)
}

//реализация Пресентера для окна регистрации
class RegistrationPresenterImplementation: RegistrationPresenter {
    
    fileprivate weak var view: RegistrationView?
    private var model: RegistrationModel
    internal var router: RegistrationRouter
    
    private var isLoad: Bool = false
    private let requestFactory = RequestFactory()
    
    //MARK: - Публичные функции
    required init(view: RegistrationView, model: RegistrationModel, router: RegistrationRouter) {
        self.view = view
        self.model = model
        self.router = router
    }
    
    //В данной функции производится проверка полученных данных
    //Если данные коррекны, вызывается метод регистрации
    //иначе выводится ошибка
    public func registrate(userName: String, password: String, email: String, isGenderMan: Bool) {
        
        if !isLoad {
            model.userName = userName.trimmingCharacters(in: .whitespacesAndNewlines)
            model.password = password.trimmingCharacters(in: .whitespacesAndNewlines)
            model.email = email.trimmingCharacters(in: .whitespacesAndNewlines)
            model.gender = isGenderMan ? "m" : "w"
            
            if model.isRegistrationDataCorrect() {
                callRegistrationRequest()
            } else if let view = view {
                view.showError(text: "Одно из полей заполнено неверно")
            }
        }
    }
    
    //MARK: - Закрытые функции
    //В данной функции происходит попытка регистрации
    //При успешной регистрации записывает данные
    //иначе выводится ошибка
    private func callRegistrationRequest() {
        changeLoad(isLoad: true)
        
        let registrationRequest = requestFactory.makeRegistrationRequestFatory()
        registrationRequest.registrate(userName: model.userName, password: model.password, email: model.email, gender: model.gender) {
            [unowned self] response in
            
            self.changeLoad(isLoad: false)
            switch response.result {
            case .success(let registrationResponse):
                UserSingleton.instance.setUser(user: registrationResponse.user)
                DispatchQueue.main.async { self.handleRegistrationSuccess() }
                
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
    //после успешной регистрации
    private func handleRegistrationSuccess() {
        router.showCatalogScene()
    }
    
}

