//
//  AddToBasketRequestFactory.swift
//  GBShop
//
//  Created by Admin on 5/13/19.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Alamofire

protocol AddToBasketRequestFactory {
    
    func addToBasket(idProduct: Int, quantity: Int, completionHandler: @escaping (DataResponse<AddToBasketResult>) -> Void)
    
}
