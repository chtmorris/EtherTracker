//
//  ETNewsVC+NewsFeed.swift
//  Ether Tracker
//
//  Created by Charlie Morris on 12/06/2016.
//  Copyright © 2016 Mind Fund Studio. All rights reserved.
//

import Foundation
import UIKit

extension ETNewsViewController {
    
    func getEtherNews() {
        
        startSpinner()
        
        ETDataManager.getEtherNewsFromUrlWithSuccess { (data) -> Void in
            
            var json: [String: AnyObject]!
            
            
            do {
                json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions()) as? [String: AnyObject]
            } catch {
                print(error)
            }
            
            guard let etherNews = EtherNewsFeed(json: json) else {
                print("Error initializing object")
                return
            }
            
            guard let newsFeed = etherNews.newsFeed else {
                print("No such item")
                return
            }
            
            self.etherNews = newsFeed
            
            let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
            dispatch_async(dispatch_get_global_queue(priority, 0)) {
                // do some task
                
                dispatch_async(dispatch_get_main_queue()) {
                    // update some UI
                    self.collectionView.reloadData()
                    self.refreshControl.endRefreshing()
                }
            }
            
        }
        
    }
    
    func refreshNewsFeed(spinnerTitle: String) {
        refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor.whiteColor()
        let attributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        let attributedTitle = NSAttributedString(string: spinnerTitle, attributes: attributes)
        refreshControl.attributedTitle = attributedTitle
        refreshControl.addTarget(self, action: #selector(ETNewsViewController.refresh(_:)), forControlEvents: UIControlEvents.ValueChanged)
        collectionView.addSubview(refreshControl)
    }
    
    func refresh(sender:AnyObject) {
        getEtherNews()
    }
}