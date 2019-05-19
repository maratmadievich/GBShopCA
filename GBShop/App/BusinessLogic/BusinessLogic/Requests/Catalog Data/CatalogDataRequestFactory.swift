//
//  CatalogDataRequestFactory.swift
//  GBShop
//
//  Created by Марат Нургалиев on 26/04/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation
import Alamofire

protocol CatalogDataRequestFactory {
    
    func getCatalogData(pageNumber: Int,
                        idCategory: Int,
                        completionHandler: @escaping (DataResponse<CatalogDataResult>) -> Void)
    
}
