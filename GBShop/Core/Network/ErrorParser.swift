//
//  ErrorParser.swift
//  GBShop
//
//  Created by Admin on 4/22/19.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation

class ErrorParser: AbstractErrorParser {
   
    func parse(_ result: Error) -> Error {
    
        return result
    }
    
    
    func parse(response: HTTPURLResponse?, data: Data?, error: Error?) -> Error? {
    
        return error
    }
    
}
