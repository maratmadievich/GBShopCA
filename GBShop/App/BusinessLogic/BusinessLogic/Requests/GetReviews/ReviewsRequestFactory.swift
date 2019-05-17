//
//  ReviewsRequestFactory.swift
//  GBShop
//
//  Created by Марат Нургалиев on 07/05/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Alamofire

protocol ReviewsRequestFactory {
    
    func getReviews(idProduct: Int,
                    completionHandler: @escaping (DataResponse<ReviewsResult>) -> Void)
    
}
