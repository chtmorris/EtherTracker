//
//  ETMainVC+ChartInteractions.swift
//  Ether Tracker
//
//  Created by Charlie Morris on 10/06/2016.
//  Copyright © 2016 Mind Fund Studio. All rights reserved.
//

import Foundation
import UIKit

extension ETMainViewController {

    
    @IBAction func dailyButtonTapped(sender: UIButton) {
        
        if dataLoaded {
            setChart(time12hours, values: price12hours)
            priceDateTime = priceDateTime12hours
            currentChartShowing = "time12hours"
        }
        
        UIView.animateWithDuration(0.5, animations: {
            self.dailyButton.alpha = 1
            self.weeklyButton.alpha = 0.5
            self.monthlyButton.alpha = 0.5
            self.yearlyButton.alpha = 0.5
        })
        
    }
    
    
    @IBAction func weeklyButtonTapped(sender: UIButton) {
        
        if dataLoaded {
            setChart(time7days, values: price7days)
            priceDateTime = priceDateTime7days
            currentChartShowing = "time7days"
        }
        
        UIView.animateWithDuration(0.5, animations: {
            self.dailyButton.alpha = 0.5
            self.weeklyButton.alpha = 1
            self.monthlyButton.alpha = 0.5
            self.yearlyButton.alpha = 0.5
        })
        
    }
    
    
    @IBAction func monthlyButtonTapped(sender: UIButton) {
        
        if dataLoaded {
            setChart(time1month, values: price1month)
            priceDateTime = priceDateTime1month
            currentChartShowing = "time1month"
        }
        
        UIView.animateWithDuration(0.5, animations: {
            self.dailyButton.alpha = 0.5
            self.weeklyButton.alpha = 0.5
            self.monthlyButton.alpha = 1
            self.yearlyButton.alpha = 0.5
        })
        
    }
    
    
    @IBAction func yearlyButtonTapped(sender: UIButton) {
        
        if dataLoaded {
            setChart(time1year, values: price1year)
            priceDateTime = priceDateTime1year
            currentChartShowing = "time1year"
        }
        
        UIView.animateWithDuration(0.5, animations: {
            self.dailyButton.alpha = 0.5
            self.weeklyButton.alpha = 0.5
            self.monthlyButton.alpha = 0.5
            self.yearlyButton.alpha = 1
        })
        
    }
    
}
