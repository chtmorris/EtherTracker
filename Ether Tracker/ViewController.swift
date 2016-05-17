//
//  ViewController.swift
//  Ether Tracker
//
//  Created by Charlie Morris on 16/05/2016.
//  Copyright © 2016 Mind Fund Studio. All rights reserved.
//

import UIKit
import Charts

class ViewController: UIViewController, ChartViewDelegate {
    
    
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
    
    
    // =================
    // MARK: - LIFECYCLE
    // =================
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        etherPriceLabel.alpha = 0
        topButtons.alpha = 0
        dailyButton.alpha = 0
        weeklyButton.alpha = 0
        monthlyButton.alpha = 0
        lineChart.alpha = 0
        lineChart.backgroundColor = UIColor.clearColor()
        
        let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun"]
        let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0]
        
        setChart(months, values: unitsSold)
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        let destinationY:CGFloat = view.bounds.height - 60
        getEtherPrice()
        
        UIView.animateWithDuration(3, delay: 0.3, options: .CurveEaseInOut, animations: {
            self.etherLogo.center.y = destinationY
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
    
    
    // ======================
    // MARK: - HELPER METHODS
    // ======================
    
    func getEtherPrice() {
        DataManager.getEtherPriceFromUrlWithSuccess { (data) -> Void in
            var json: [String: AnyObject]!
            
            // 1
            do {
                json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions()) as? [String: AnyObject]
            } catch {
                print(error)
            }
            
            // 2
            guard let etherData = EtherInfo(json: json) else {
                print("Error initializing object")
                return
            }
            
            // 3
            guard let etherPrice = etherData.price else {
                print("No such item")
                return
            }
            
            // 4
            let priceToBeDisplayed = String(format: "%.3f", etherPrice.btc!)
            print(etherPrice.btc)
            self.etherPriceLabel.text = "1 eth = \(priceToBeDisplayed) BTC"
            
//            dispatch_async(dispatch_get_main_queue(), ^(void){
//                self.etherPriceLabel.text = "1 eth = \(priceToBeDisplayed) BTC"
//            });
            
            
        }
    }
    
    
    func setChart(dataPoints: [String], values: [Double]) {
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
//        let pieChartDataSet = PieChartDataSet(yVals: dataEntries, label: "Units Sold")
//        let pieChartData = PieChartData(xVals: dataPoints, dataSet: pieChartDataSet)
//        pieChartView.data = pieChartData
        
        var colors: [UIColor] = []
        
        for i in 0..<dataPoints.count {
            let red = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))
            
            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
        }
        
//        pieChartDataSet.colors = colors
        
        
        let lineChartDataSet = LineChartDataSet(yVals: dataEntries, label: "Units Sold")
        let lineChartData = LineChartData(xVals: dataPoints, dataSet: lineChartDataSet)
        lineChart.data = lineChartData
        
    }


}

