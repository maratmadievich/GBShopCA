//
//  AddReviewRequestFactory.swift
//  GBShop
//
//  Created by Марат Нургалиев on 07/05/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Alamofire

protocol AddReviewRequestFactory {
    
    func addReview(idUser: Int, idProduct: Int, text: String, completionHandler: @escaping (DataResponse<AddReviewResult>) -> Void)
    
}
