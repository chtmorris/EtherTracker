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
    
    func getLastxHoursPrice(numberOfHours: Int, dateDisplay: String) {
        let lastxHours = Array(self.etherHistorialPrices.suffix(numberOfHours))
        
        var time = [String]()
        var price = [Double]()
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000Z"
        
        for index in 0...(lastxHours.count - 1){
            let timeString = lastxHours[index].time!
            
            //Append time data
            let date = dateFormatter.dateFromString(timeString)
            let calendar = NSCalendar.currentCalendar()
            let comp = calendar.components([.Month, .Day, .Weekday, .Hour], fromDate: date!)
            let month = comp.month
            let day = comp.day
            let weekday = comp.weekday
            let hour = comp.hour
            
            if dateDisplay == "hours" {
                time.append("\(hour):00")
            } else if dateDisplay == "days" {
                let day = dateFormatter.shortWeekdaySymbols
                let daySymbol = day[weekday - 1]
                time.append("\(daySymbol) \(hour):00")
            } else if dateDisplay == "month" {
                let months = dateFormatter.shortMonthSymbols
                let monthSymbol = months[month - 1]
                time.append("\(monthSymbol) \(day)")
            }
            
            //Append price data
            price.append(Double(lastxHours[index].usd!))
        }
        
        setChart(time, values: price)
        
    }
    
    func getLastxDaysPrice(numberofDays: Int){
        let lastxDaysInHours = Array(self.etherHistorialPrices.suffix(numberofDays * 24))
        
        var time = [String]()
        var price = [Double]()
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000Z"
        
        for index in 0...(lastxDaysInHours.count - 1){
            let timeString = lastxDaysInHours[index].time!
            
            //Append time data
            let date = dateFormatter.dateFromString(timeString)
            let calendar = NSCalendar.currentCalendar()
            let comp = calendar.components([.Month, .Day, .Hour], fromDate: date!)
            let month = comp.month
            let day = comp.day
            let hour = comp.hour
            
            if hour % 24 == 0 {
                let months = dateFormatter.shortMonthSymbols
                let monthSymbol = months[month - 1]
                time.append("\(monthSymbol) \(day)")
                price.append(Double(lastxDaysInHours[index].usd!))
            }
            //Append price data
            
        }
        
        setChart(time, values: price)
        
    }
    
}