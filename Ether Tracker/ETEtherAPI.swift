//
//  EtherPrice.swift
//  Ether Tracker
//
//  Created by Charlie Morris on 17/05/2016.
//  Copyright © 2016 Mind Fund Studio. All rights reserved.
//

import Foundation
import Gloss

struct EtherInfo: Decodable {
    
    let symbol: String?
    let position: String?
    let name: String?
    let supply: String?
    let change: String?
    let price: EtherPrice?
    
    
    // MARK: - Deserialization
    init?(json: JSON) {
        self.symbol = "symbol" <~~ json
        self.position = "position" <~~ json
        self.name = "name" <~~ json
        self.supply = "supply" <~~ json
        self.change = "change" <~~ json
        self.price = "price" <~~ json
    }
    
}

struct EtherPrice: Decodable {
    
    let usd: Float?
    let eur: Float?
    let btc: Float?
    
    init?(json: JSON) {
        self.usd = "usd" <~~ json
        self.eur = "eur" <~~ json
        self.btc = "btc" <~~ json
    }
}
