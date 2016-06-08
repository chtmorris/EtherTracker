//
//  ETNewsArticleCell.swift
//  Ether Tracker
//
//  Created by Charlie Morris on 05/06/2016.
//  Copyright © 2016 Mind Fund Studio. All rights reserved.
//

import UIKit

class ETNewsArticleCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var publicationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    var urlLink: String!
    
    func configure(title title: String, publication: String, date: String, link: String) {
        titleLabel.text = title
        publicationLabel.text = publication
        dateLabel.text = date
        urlLink = link
    }

}
