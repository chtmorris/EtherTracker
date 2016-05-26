//
//  ViewController.swift
//  Ether Tracker
//
//  Created by Charlie Morris on 16/05/2016.
//  Copyright © 2016 Mind Fund Studio. All rights reserved.
//

import UIKit
import Charts

class ETMainViewController: UIViewController, ChartViewDelegate {
    
    
    // ==================
    // MARK: - PROPERTIES
    // ==================
    
    @IBOutlet weak var etherLogo: UIImageView!
    @IBOutlet weak var etherPriceLabel: UILabel!
    @IBOutlet weak var dailyButton: UIButton!
    @IBOutlet weak var weeklyButton: UIButton!
    @IBOutlet weak var monthlyButton: UIButton!
    @IBOutlet weak var yearlyButton: UIButton!
    @IBOutlet weak var lineChart: LineChartView!
    @IBOutlet weak var etherLogoYCoordinates: NSLayoutConstraint!
    
    var etherPrices: EtherInfo!
    var etherHistorialPrices: [EtherHistoricalPrice]!
    var setCurrencyTo = Currency.USD
    
    
    // =================
    // MARK: - LIFECYCLE
    // =================
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        etherPriceLabel.alpha = 0
        etherPriceLabel.text = ""
        dailyButton.alpha = 0
        weeklyButton.alpha = 0
        monthlyButton.alpha = 0
        yearlyButton.alpha = 0
        lineChart.alpha = 0
        lineChart.backgroundColor = UIColor.clearColor()
        lineChart.noDataText = "Struggling to connect to the interweb..."
        
    }
    
    override func viewDidAppear(animated: Bool) {
        getEtherPrice()
        getHistoricalEtherPrice()
        
        let destinationY:CGFloat = (view.bounds.height)/2 - 60
        self.etherLogoYCoordinates.constant = destinationY
        
        UIView.animateWithDuration(3, delay: 0.3, options: .CurveEaseInOut, animations: {
            self.view.layoutIfNeeded()
            self.etherLogo.transform = CGAffineTransformMakeScale(0.3, 0.3)
            }, completion: { (finished: Bool) -> Void in
                UIView.animateWithDuration(1, animations: {
                    
                    self.etherPriceLabel.alpha = 1
                    self.dailyButton.alpha = 1
                    self.weeklyButton.alpha = 0.5
                    self.monthlyButton.alpha = 0.5
                    self.yearlyButton.alpha = 0.5
                    self.lineChart.alpha = 1
                })
        })
    
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    
    // =======================
    // MARK: - GET ETHER PRICE
    // =======================
    
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

            // 1. Get last 7 hours
            self.getLastxHoursPrice(24 * 30)

            //2. Get today's date
//            self.getLastxDaysPrice(7)
            
            //3. Compare data set to today's date and pull last 7 days
            
        }
    }
    
    
    // =========================
    // MARK: - PARSE ETHER PRICE
    // =========================
    
    func getLastxHoursPrice(numberOfHours: Int) {
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
            let comp = calendar.components([.Hour, .Minute], fromDate: date!)
            let hour = comp.hour
            time.append("\(hour):00")
            
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
            let comp = calendar.components([.Hour, .Minute], fromDate: date!)
            let hour = comp.hour
            
            if hour % 24 == 0 {
                time.append("\(hour):00")
                price.append(Double(lastxDaysInHours[index].usd!))
            }
            //Append price data
            
        }
        
        setChart(time, values: price)

        
    }
    
    
    // ====================
    // MARK: - CREATE CHART
    // ====================
    
    func setChart(dataPoints: [String], values: [Double]) {
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        var colors: [UIColor] = []
        
        for i in 0..<dataPoints.count {
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
    
    
    // ====================
    // MARK: - INTERACTIONS
    // ====================
    
    @IBAction func etherLogoTapped(sender: UIButton) {
        
        if etherPrices != nil {
            
            let currencyPrice: String
            let currencyName: String
            
            switch setCurrencyTo {
            case Currency.USD:
                currencyPrice = String(format: "%.3f", etherPrices.price!.usd!)
                currencyName = Currency.USD.title
                setCurrencyTo = Currency.EUR
                
            case Currency.EUR:
                currencyPrice = String(format: "%.3f", etherPrices.price!.eur!)
                currencyName = Currency.EUR.title
                setCurrencyTo = Currency.BTC
                
            case Currency.BTC:
                currencyPrice = String(format: "%.3f", etherPrices.price!.btc!)
                currencyName = Currency.BTC.title
                setCurrencyTo = Currency.USD
            }
            
            self.etherPriceLabel.text = "1 eth = \(currencyPrice) \(currencyName)"
        }
        
    }


}

