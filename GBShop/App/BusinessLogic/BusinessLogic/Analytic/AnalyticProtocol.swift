//
//  AnalyticProtocol.swift
//  GBShop
//
//  Created by Admin on 5/31/19.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation

/// Протокол для отправки событий аналитики
public protocol AnalyticProtocol {
    
    /// Отправляет события в сервис аналитики
    /// Параметры:
    /// - method: метод, который нужно залогировать
    /// - parameters: параметры метода
    func sendEvent(method: EventMethod, parameters: Dictionary<String, String>?)
    
    /// Отправляет ошибки в сервис аналитики
    /// Параметры:
    /// - method: метод, который нужно залогировать
    /// - message: сообщение об ошибке
    func assertionFailure(method: EventMethod, message: String)
}
