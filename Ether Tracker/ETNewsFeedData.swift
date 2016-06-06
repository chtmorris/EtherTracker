//
//  ETNewsFeedData.swift
//  Ether Tracker
//
//  Created by Charlie Morris on 05/06/2016.
//  Copyright © 2016 Mind Fund Studio. All rights reserved.
//

import Foundation
import Gloss

struct EtherNewsFeed: Decodable {
    
    let newsFeed: [EtherNewsFeedArticles]?
    
    // MARK: - Deserialization
    init?(json: JSON) {
        self.newsFeed = "newsfeed" <~~ json
    }
    
}

struct EtherNewsFeedArticles: Decodable {
    
    let title: String?
    let publication: String?
    let date: String?
    let link: String?
    
    // MARK: - Deserialization
    init?(json: JSON) {
        self.title = "title" <~~ json
        self.publication = "publication" <~~ json
        self.date = "date" <~~ json
        self.link = "link" <~~ json
    }
}
