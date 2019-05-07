//
//  RemoveReviewRequestFactory.swift
//  GBShop
//
//  Created by Марат Нургалиев on 07/05/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Alamofire

protocol RemoveReviewRequestFactory {
    
    func removeReview(id: Int, completionHandler: @escaping (DataResponse<RemoveReviewResult>) -> Void)
    
}
