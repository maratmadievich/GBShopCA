//
//  CrashlyticsAnalytic.swift
//  GBShop
//
//  Created by Admin on 5/31/19.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation
import Answers

/// Класс для отправки событий аналитики
/// Для передачи используется фреймворк Answers
public class CrashlyticsAnalytic: AnalyticProtocol {
    
    public func sendEvent(method: EventMethod, parameters: Dictionary<String, String>?) {
        Answers.logLogin(withMethod: method.rawValue, success: 1, customAttributes: parameters)
    }
    
    /// Фиксирует ошибки для аналитики
    ///  - DEBUG: выводит ошибку в консоль
    ///  - RELEASE: отправляет ошибки в сборщик
    public func assertionFailure(method: EventMethod, message: String) {
        #if DEBUG
        print("\(method.rawValue): \(message)")
        #else
        Answers.logCustomEvent(withName: method.rawValue, customAttributes: parameters)
        #endif
    }
    
}
