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
    @IBOutlet weak var newsButton: UIButton!
    @IBOutlet weak var refreshButton: UIButton!
    
    var etherPrices: EtherInfo!
    var etherHistorialPrices: [EtherHistoricalPrice]!
    var setCurrencyTo = Currency.USD
    var priceDateTime  = [String]()
    var dataLoaded = false
    var currentChartShowing = "time1month"
    var appJustLaunched = true
    
    // 12 hour data
    var time12hours = [String]()
    var price12hours  = [Double]()
    var priceDateTime12hours  = [String]()
    
    // 7 day data
    var time7days = [String]()
    var price7days = [Double]()
    var priceDateTime7days = [String]()
    
    // 1 month data
    var time1month = [String]()
    var price1month = [Double]()
    var priceDateTime1month = [String]()
    
    // 1 year data
    var time1year = [String]()
    var price1year = [Double]()
    var priceDateTime1year = [String]()
    
    
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
        newsButton.alpha = 0
        refreshButton.alpha = 0
        lineChart.backgroundColor = UIColor.clearColor()
        lineChart.noDataText = "Loading data..."
        
    }
    
    override func viewDidAppear(animated: Bool) {
        getEtherPrice()
        
        if appJustLaunched {
            getHistoricalEtherPriceOnAppLaunch()
        
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
                        self.newsButton.alpha = 0.5
                        self.refreshButton.alpha = 0.5
                        self.lineChart.alpha = 1
                    })
            })
            
            appJustLaunched = false
        }
        
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    
    // ===============================
    // MARK: - TAB BUTTON INTERACTIONS
    // ===============================
    
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
    
    @IBAction func refreshButtonTapped(sender: UIButton) {
        pulseEtherLogo()
        getEtherPrice()
        refreshHistoricalEtherPrice(currentChartShowing)
    }
    
    
    func chartValueSelected(chartView: ChartViewBase, entry: ChartDataEntry, dataSetIndex: Int, highlight: ChartHighlight) {
        self.priceDateTimeLabel.text = priceDateTime[entry.xIndex]
    }
    
    
    // ===============
    // MARK: - HELPERS
    // ===============
    
    func pulseEtherLogo() {
        for index in 0...3 {
            Helper.delay(Double(index) * 1, closure: {
                UIView.animateWithDuration(0.5, delay: 0, options: .CurveEaseInOut, animations: {
                    self.etherLogo.alpha = 0.2
                    }, completion: { (Bool) in
                        UIView.animateWithDuration(0.5, animations: {
                            if index != 3 {
                                self.etherLogo.alpha = 0.5
                            } else {
                                self.etherLogo.alpha = 1
                            }
                        })
                })
            })
            
        }
    }
    
}








