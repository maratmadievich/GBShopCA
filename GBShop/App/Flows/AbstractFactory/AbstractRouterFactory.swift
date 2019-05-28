//
//  AbstractRouterFactory.swift
//  GBShop
//
//  Created by Марат Нургалиев on 26/05/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit

protocol AbstractRouterFactory {
    func prepare(for segue: UIStoryboardSegue, sender: Any?)
}

extension AbstractRouterFactory {
    func prepare(for segue: UIStoryboardSegue, sender: Any?) { }
}
