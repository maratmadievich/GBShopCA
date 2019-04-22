//
//  AbstractErrorParser.swift
//  GBShop
//
//  Created by Admin on 4/22/19.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation

protocol AbstractErrorParser {
   
    func parse(_ result: Error) -> Error
    
    func parse(response: HTTPURLResponse?, data: Data?, error: Error?) -> Error?
}

