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
    @IBOutlet weak var priceDateTimeLabel: UILabel!
    
    var etherPrices: EtherInfo!
    var etherHistorialPrices: [EtherHistoricalPrice]!
    var setCurrencyTo = Currency.USD
    
    var time = [String]()
    var price = [Double]()
    var priceDateTime = [String]()
    
    
    // =================
    // MARK: - LIFECYCLE
    // =================
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        lineChart.delegate = self
        
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
                    self.dailyButton.alpha = 0.5
                    self.weeklyButton.alpha = 0.5
                    self.monthlyButton.alpha = 1
                    self.yearlyButton.alpha = 0.5
                    self.lineChart.alpha = 1
                })
        })
        

        
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
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
    
    func chartValueSelected(chartView: ChartViewBase, entry: ChartDataEntry, dataSetIndex: Int, highlight: ChartHighlight) {
        self.priceDateTimeLabel.text = priceDateTime[entry.xIndex]
    }

    @IBAction func dailyButtonTapped(sender: UIButton) {
        
        getLastxHoursPrice(12, dateDisplay: "hours")
        
        UIView.animateWithDuration(0.5, animations: {
            self.dailyButton.alpha = 1
            self.weeklyButton.alpha = 0.5
            self.monthlyButton.alpha = 0.5
            self.yearlyButton.alpha = 0.5
        })
        
    }
    
    
    @IBAction func weeklyButtonTapped(sender: UIButton) {
        
        getLastxHoursPrice(7 * 24, dateDisplay: "days")
        
        UIView.animateWithDuration(0.5, animations: {
            self.dailyButton.alpha = 0.5
            self.weeklyButton.alpha = 1
            self.monthlyButton.alpha = 0.5
            self.yearlyButton.alpha = 0.5
        })
        
    }
    
    
    @IBAction func monthlyButtonTapped(sender: UIButton) {
        
        getLastxHoursPrice(30 * 24, dateDisplay: "month")
        
        UIView.animateWithDuration(0.5, animations: {
            self.dailyButton.alpha = 0.5
            self.weeklyButton.alpha = 0.5
            self.monthlyButton.alpha = 1
            self.yearlyButton.alpha = 0.5
        })
        
    }
    
    
    @IBAction func yearlyButtonTapped(sender: UIButton) {
        
        getLastxDaysPrice(365)
        
        UIView.animateWithDuration(0.5, animations: {
            self.dailyButton.alpha = 0.5
            self.weeklyButton.alpha = 0.5
            self.monthlyButton.alpha = 0.5
            self.yearlyButton.alpha = 1
        })
        
    }
    
    

}







