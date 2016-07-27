//
//  ETMainVC+ChartData.swift
//  Ether Tracker
//
//  Created by Charlie Morris on 26/05/2016.
//  Copyright © 2016 Mind Fund Studio. All rights reserved.
//

import Foundation
import UIKit

extension ETMainViewController {
    
//    func getLastxHoursPrice(numberOfHours: Int, dateDisplay: String) -> ([String], [Double], [String]) {
//        let lastxHours = Array(self.etherHistorialPrices.suffix(numberOfHours))
//        
//        var time:[String] = []
//        var price:[Double] = []
//        var priceDateTime:[String] = []
//        
//        let dateFormatter = NSDateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000Z"
//        
//        for index in 0...(lastxHours.count - 1){
//            let timeString = lastxHours[index].time!
//            
//            // Format time data
//            let date = dateFormatter.dateFromString(timeString)
//            let calendar = NSCalendar.currentCalendar()
//            let comp = calendar.components([.Month, .Day, .Weekday, .Hour], fromDate: date!)
//            let month = comp.month
//            let day = comp.day
//            let weekday = comp.weekday
//            let hour = comp.hour
//            
//            let dayFormatted = dateFormatter.shortWeekdaySymbols
//            let daySymbol = dayFormatted[weekday - 1]
//            let monthFormatted = dateFormatter.shortMonthSymbols
//            let monthSymbol = monthFormatted[month - 1]
//            
//            // Append time data
//            if dateDisplay == "hours" {
//                time.append("\(hour):00")
//            } else if dateDisplay == "days" {
//                time.append("\(daySymbol) \(hour):00")
//            } else if dateDisplay == "month" {
//                time.append("\(monthSymbol) \(day)")
//            }
//            
//            // Append price data
//            let priceAtTime = Double(lastxHours[index].usd!)
//            price.append(priceAtTime)
//            priceDateTime.append("$\(String(format: "%.2f", priceAtTime)), \(monthSymbol) \(day), \(hour):00")
//        }
//        
//        return (time, price, priceDateTime)
//    }
//    
//    func getLastxDaysPrice(numberofDays: Int) -> ([String], [Double], [String]){
//        let lastxDaysInHours = Array(self.etherHistorialPrices.suffix(numberofDays * 24))
//        
//        var time:[String] = []
//        var price:[Double] = []
//        var priceDateTime:[String] = []
//        
//        let dateFormatter = NSDateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000Z"
//        
//        for index in 0...(lastxDaysInHours.count - 1){
//            let timeString = lastxDaysInHours[index].time!
//            
//            // Format time data
//            let date = dateFormatter.dateFromString(timeString)
//            let calendar = NSCalendar.currentCalendar()
//            let comp = calendar.components([.Month, .Day, .Hour], fromDate: date!)
//            let month = comp.month
//            let day = comp.day
//            let hour = comp.hour
//            
//            let monthFormatted = dateFormatter.shortMonthSymbols
//            let monthSymbol = monthFormatted[month - 1]
//            
//            // Append time data
//            if hour % 24 == 0 {
//                time.append("\(monthSymbol) \(day)")
//                
//                let priceAtTime = Double(Double(lastxDaysInHours[index].usd!))
//                price.append(priceAtTime)
//                priceDateTime.append("$\(String(format: "%.2f", priceAtTime)), \(monthSymbol) \(day), \(hour):00")
//            }
//            
//        }
//        
//        return (time, price, priceDateTime)
//    }
    
}