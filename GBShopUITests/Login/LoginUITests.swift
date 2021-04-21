//
//  LoginUITests.swift
//  GBShopUITests
//
//  Created by Марат Нургалиев on 28/05/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import XCTest
@testable import GBShop

class UITestsUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDown() {
        app = nil
    }
    
    func testLoginWithoutUsername() {
        enterAuthData(login: nil, password: "pass")
        checkAuth(message: "Неверный логин или пароль")
    }
    
    func testLoginWithoutPassword() {
        enterAuthData(login: "login", password: nil)
        checkAuth(message: "Неверный логин или пароль")
    }
    
    func testLogin() {
        enterAuthData(login: "login", password: "pass")
    }
    
    func testRegistrate() {
        let buttonRegistrate = app.buttons["buttonRegistrate"]
        buttonRegistrate.tap()
    }
    
    
    private func enterAuthData(login: String?, password: String?) {
        let mainView = app.otherElements["mainView"]
        let buttonLogin = app.buttons["buttonLogin"]
        if let login = login {
            let textFieldLogin = app.textFields["textFieldLogin"]
            textFieldLogin.tap()
            textFieldLogin.typeText(login)
            
            mainView.tap()
        }
        if let password = password {
            let textFieldPassword = app.secureTextFields["textFieldPassword"]
            textFieldPassword.tap()
            textFieldPassword.typeText(password)
            
            mainView.tap()
        }
        buttonLogin.tap()
    }
    
    private func checkAuth(message: String) {
        let token = addUIInterruptionMonitor(withDescription: message, handler: { alert in
            
            XCTAssertEqual("Ошибка", alert.label)
            alert.buttons["Хорошо"].tap()
            return true
        })
        // Диалоги находятся в другом потоке, поэтому дадим им некоторое время для синхронизации
        RunLoop.current.run(until: Date(timeInterval: 2, since: Date()))
        
        // Чтобы снова взаимодействовать с приложением
        app.tap()
        removeUIInterruptionMonitor(token)
    }
    
}


