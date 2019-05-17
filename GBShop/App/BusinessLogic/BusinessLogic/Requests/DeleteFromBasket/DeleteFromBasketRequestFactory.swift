//
//  DeleteFromBasketRequestFactory.swift
//  GBShop
//
//  Created by Admin on 5/13/19.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Alamofire

protocol DeleteFromBasketRequestFactory {
    
    func deleteFromBasket(idProduct: Int, completionHandler: @escaping (DataResponse<DeleteFromBasketResult>) -> Void)
    
}
