//
//  ETMainVC+DataRequest.swift
//  Ether Tracker
//
//  Created by Charlie Morris on 26/05/2016.
//  Copyright © 2016 Mind Fund Studio. All rights reserved.
//

import Foundation
import UIKit

extension ETMainViewController {
    
    func getEtherPrice() {
        
        ETDataManager.getEtherPriceFromUrlWithSuccess { (data) -> Void in
            var json: [String: AnyObject]!
                        
            do {
                json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions()) as? [String: AnyObject]
            } catch {
                print(error)
            }
            
            guard let etherData = EtherInfo(json: json) else {
                print("Error initializing object")
                return
            }
            
            guard let etherPrice = etherData.price else {
                print("No such item")
                return
            }
            
            self.etherPrices = etherData
            
            let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
            dispatch_async(dispatch_get_global_queue(priority, 0)) {
                // do some task
                let priceToBeDisplayed = String(format: "%.3f", etherPrice.btc!)
                
                dispatch_async(dispatch_get_main_queue()) {
                    // update some UI
                    self.etherPriceLabel.text = "1 eth = \(priceToBeDisplayed) BTC"
                }
            }
            
        }
        
    }
    
    
    func getHistoricalEtherPrice() {
        
        ETDataManager.getEtherHistoricalPriceFromUrlWithSuccess { (data) -> Void in
            var json: [String: AnyObject]!
            
            do {
                json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions()) as? [String: AnyObject]
            } catch {
                print(error)
            }
                        
            guard let etherHistoricalData = EtherHistoricalData(json: json) else {
                print("Error initializing object")
                return
            }
            
            guard let etherHistoricalPrice = etherHistoricalData.historicalData else {
                print("No such item")
                return
            }
            
            self.etherHistorialPrices = etherHistoricalPrice
            
            // Set-up first chart
            (self.time1month, self.price1month, self.priceDateTime1month) = self.getLastxHoursPrice(30 * 24, dateDisplay: "month")
            self.setChart(self.time1month, values: self.price1month)
            self.priceDateTime = self.priceDateTime1month
            
            // Load up other data sets
            (self.time12hours, self.price12hours, self.priceDateTime12hours) = self.getLastxHoursPrice(12, dateDisplay: "hours")
            (self.time7days, self.price7days, self.priceDateTime7days) = self.getLastxHoursPrice(24 * 7, dateDisplay: "days")
            (self.time1year, self.price1year, self.priceDateTime1year) = self.getLastxDaysPrice(365)
            
            self.dataLoaded = true
        }
        
    }
    
}