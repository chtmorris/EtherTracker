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
    @IBOutlet weak var topButtons: UIImageView!
    @IBOutlet weak var dailyButton: UIButton!
    @IBOutlet weak var weeklyButton: UIButton!
    @IBOutlet weak var monthlyButton: UIButton!
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
        topButtons.alpha = 0
        dailyButton.alpha = 0
        weeklyButton.alpha = 0
        monthlyButton.alpha = 0
        lineChart.alpha = 0
        lineChart.backgroundColor = UIColor.clearColor()
        
//        let days = ["Mon", "Tues", "Weds", "Thurs", "Fri", "Sat", "Sun"]
//        let price = [0.011, 0.010, 0.012, 0.015, 0.013, 0.015, 0.019]
//        
//        setChart(days, values: price)
        
        
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
                    self.topButtons.alpha = 1
                    self.dailyButton.alpha = 1
                    self.weeklyButton.alpha = 1
                    self.monthlyButton.alpha = 1
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
            print(self.etherHistorialPrices[0].time!)
            
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'hh:mm:ss.000Z"
            let date = dateFormatter.dateFromString(self.etherHistorialPrices[0].time!)
            
            
            // 1. Get last 7 hours
            self.getLastSevenHoursPrice()

            //2. Get today's date
            
            
            //3. Compare data set to today's date and pull last 7 days
            
            
        }
    }
    
    
    // =========================
    // MARK: - PARSE ETHER PRICE
    // =========================
    
    func getLastSevenHoursPrice() {
        let lastSevenHours = Array(self.etherHistorialPrices.suffix(7))
        
        let time = ["Mon", "Tues", "Weds", "Thurs", "Fri", "Sat", "Sun"]
        var price = [Double]()
        
        for index in 0...(lastSevenHours.count - 1){
            price.append(Double(lastSevenHours[index].usd!))
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
        
        let lineChartDataSet = LineChartDataSet(yVals: dataEntries, label: "Units Sold")
        let lineChartData = LineChartData(xVals: dataPoints, dataSet: lineChartDataSet)
        lineChartData.setValueTextColor(UIColor.whiteColor())
        lineChart.data = lineChartData
        
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

