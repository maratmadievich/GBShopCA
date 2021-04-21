//
//  PaymentRequestFactory.swift
//  GBShop
//
//  Created by Марат Нургалиев on 28/05/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation
import Alamofire

protocol PaymentRequestFactory {
    
    func payment(completionHandler: @escaping (DataResponse<PaymentResult>) -> Void)
}
