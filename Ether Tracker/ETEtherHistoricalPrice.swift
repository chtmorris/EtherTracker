//
//  ETEtherHistoricalPrice.swift
//  Ether Tracker
//
//  Created by Charlie Morris on 19/05/2016.
//  Copyright © 2016 Mind Fund Studio. All rights reserved.
//

import Foundation
import Gloss

struct EtherHistoricalData: Decodable {
    
    let historialData: EtherHistoricalPrice?
    
    // MARK: - Deserialization
    init?(json: JSON) {
        self.historialData = "data" <~~ json
    }
    
}

struct EtherHistoricalPrice: Decodable {
    
    let time: String?
    let usd: Float?
    
    init?(json: JSON) {
        self.time = "time" <~~ json
        self.usd = "usd" <~~ json
    }
}
