//
//  ETEtherHistoricalPrice.swift
//  Ether Tracker
//
//  Created by Charlie Morris on 19/05/2016.
//  Copyright © 2016 Mind Fund Studio. All rights reserved.
//

import Foundation
import Gloss

//struct EtherHistoricalData: Decodable {
//    
//    let historicalData: [EtherHistoricalPrice]?
//    
//    // MARK: - Deserialization
//    init?(json: JSON) {
//        self.historicalData = "data" <~~ json
//    }
//    
//}

struct EtherHistoricalPrice: Decodable {
    
    let time: Int?
    let usd: Float?
    
    // MARK: - Deserialization
    init?(json: JSON) {
        self.time = "date" <~~ json
        self.usd = "weightedAverage" <~~ json
    }
}
