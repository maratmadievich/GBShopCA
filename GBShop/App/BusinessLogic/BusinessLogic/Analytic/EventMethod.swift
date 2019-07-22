//
//  EventMethod.swift
//  GBShop
//
//  Created by Admin on 5/31/19.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation

/// Перечисление методов для аналитики
/// - login: авторизация
/// - registration: регистрация
/// - catalog: получение списка товаров
/// - productInfo: информация о товаре
/// - reviews: отзывы
/// - addToBasket: добавление в корзину
/// - basket: получение товаров из корзины
/// - payment: оплата
public enum EventMethod: String {
    case login
    case registration
    case profile
    case catalog
    case productInfo
    case reviews
    case addToBasket
    case basket
    case payment
}
