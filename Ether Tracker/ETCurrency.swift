//
//  CurrencyConversion.swift
//  Ether Tracker
//
//  Created by Charlie Morris on 19/05/2016.
//  Copyright © 2016 Mind Fund Studio. All rights reserved.
//

import Foundation

enum Currency {
    case USD, EUR, BTC
    
    var title: String {
        switch self {
        case USD:
            return "USD"
        case EUR:
            return "EUR"
        case BTC:
            return "BTC"
        }
    }
}
