//
//  BaseUrlSingleton.swift
//  GBShop
//
//  Created by Admin on 5/29/19.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation

class BaseUrlSingleton {
    
    static let instance = BaseUrlSingleton()
    private init(){}
    
    private static let baseUrl = URL(string: "http://10.12.2.82:8181/")!
    //10.12.2.82
    //192.168.1.72
    
    
    
    
    func getUrl() -> URL {
        
        return BaseUrlSingleton.baseUrl
    }
}
