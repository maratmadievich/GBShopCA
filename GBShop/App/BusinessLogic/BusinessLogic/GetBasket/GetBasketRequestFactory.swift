//
//  GetBasketRequestFactory.swift
//  GBShop
//
//  Created by Admin on 5/13/19.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Alamofire

protocol GetBasketRequestFactory {
    
    func getBasket(idUser: Int, completionHandler: @escaping (DataResponse<GetBasketResult>) -> Void)
    
}
