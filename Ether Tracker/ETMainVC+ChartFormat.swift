//
//  ETMainVC+ChartFormat.swift
//  Ether Tracker
//
//  Created by Charlie Morris on 26/05/2016.
//  Copyright © 2016 Mind Fund Studio. All rights reserved.
//

import UIKit
import Charts

extension ETMainViewController {
    
    func setChart(dataPoints: [String], values: [Double]) {
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        var colors: [UIColor] = []
        
        for _ in 0..<dataPoints.count {
            let red = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))
            
            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
        }
        
        // Format Data Set
        let lineChartDataSet = LineChartDataSet(yVals: dataEntries, label: "Units Sold")
        lineChartDataSet.drawCirclesEnabled = false
        lineChartDataSet.drawCubicEnabled = true
        lineChartDataSet.drawFilledEnabled = true
        lineChartDataSet.highlightColor = UIColor.whiteColor()
        
        // Format Data Points
        let lineChartData = LineChartData(xVals: dataPoints, dataSet: lineChartDataSet)
        lineChartData.setValueTextColor(UIColor.whiteColor())
        let formatter: NSNumberFormatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
        lineChartData.setValueFormatter(formatter)
        lineChart.data = lineChartData
        
        // Format Chart Axes
        lineChart.xAxis.labelTextColor = UIColor.whiteColor()
        lineChart.leftAxis.labelTextColor = UIColor.whiteColor()
        lineChart.xAxis.drawGridLinesEnabled = false
        lineChart.leftAxis.drawGridLinesEnabled = false
        lineChart.xAxis.drawAxisLineEnabled = false
        lineChart.rightAxis.enabled = false
        
        // Format Other Chart Attributes
        lineChart.descriptionText = ""
        lineChart.legend.textColor = UIColor.whiteColor()
        lineChart.legend.labels = ["Price - USD"]
        lineChart.animate(xAxisDuration: 1.0, yAxisDuration: 0.0, easingOption: .Linear)
    }
    
}