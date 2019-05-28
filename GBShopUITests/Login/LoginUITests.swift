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
    
    
    func testSuccess() {
        
        let scrollViewsQuery = app.textFields.element(boundBy: 0)
//        let loginTextField = scrollViewsQuery.children(matching: .textField).element(boundBy: 0)
//        loginTextField.tap()
//        loginTextField.typeText("admin")
//        let app = XCUIApplication()
//        app.textFields["Логин"].tap()
//        
//        app/*@START_MENU_TOKEN@*/.keys["l"]/*[[".keyboards.keys[\"l\"]",".keys[\"l\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//        
//        let oKey = app/*@START_MENU_TOKEN@*/.keys["o"]/*[[".keyboards.keys[\"o\"]",".keys[\"o\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
//        oKey.tap()
//        oKey.tap()
//        
//        let gKey = app/*@START_MENU_TOKEN@*/.keys["g"]/*[[".keyboards.keys[\"g\"]",".keys[\"g\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
//        gKey.tap()
//        gKey.tap()
//        app/*@START_MENU_TOKEN@*/.keys["i"]/*[[".keyboards.keys[\"i\"]",".keys[\"i\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//        
//        let nKey = app/*@START_MENU_TOKEN@*/.keys["n"]/*[[".keyboards.keys[\"n\"]",".keys[\"n\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
//        nKey.tap()
//        nKey.tap()
//        
//        let element = app.otherElements.containing(.navigationBar, identifier:"Авторизация").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
//        element.tap()
//        app.secureTextFields["Пароль"].tap()
//        
//        let pKey = app/*@START_MENU_TOKEN@*/.keys["p"]/*[[".keyboards.keys[\"p\"]",".keys[\"p\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
//        pKey.tap()
//        pKey.tap()
//        app/*@START_MENU_TOKEN@*/.keys["a"]/*[[".keyboards.keys[\"a\"]",".keys[\"a\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//        
//        let sKey = app/*@START_MENU_TOKEN@*/.keys["s"]/*[[".keyboards.keys[\"s\"]",".keys[\"s\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
//        sKey.tap()
//        sKey.tap()
//        element.tap()
//        app.buttons["Войти"].tap()
        
        
//        let scrollViewsQuery = app.scrollViews
//        let loginTextField = scrollViewsQuery.children(matching: .textField).element(boundBy: 0)
//        loginTextField.tap()
//        loginTextField.typeText("admin")
//
//        let passwordTextField = scrollViewsQuery.children(matching: .textField).element(boundBy: 1)
//        passwordTextField.tap()
//        passwordTextField.typeText("123456")
//
//        let button = scrollViewsQuery.buttons["Войти"]
//        button.tap()
//
//        let resultLabel = scrollViewsQuery.staticTexts["Данные верны"]
//        XCTAssertNotNil(resultLabel)
    }
}
