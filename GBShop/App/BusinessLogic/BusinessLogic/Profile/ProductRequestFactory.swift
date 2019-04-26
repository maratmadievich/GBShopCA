//
//  ProductRequestFactory.swift
//  GBShop
//
//  Created by Марат Нургалиев on 26/04/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation
import Alamofire

protocol ProductRequestFactory {
    
    func getProductBy(id: Int,
                      completionHandler: @escaping (DataResponse<ProductResult>) -> Void)
    
}
