//
//  ETNewsViewController.swift
//  Ether Tracker
//
//  Created by Charlie Morris on 04/06/2016.
//  Copyright © 2016 Mind Fund Studio. All rights reserved.
//

import UIKit

class ETNewsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    // ==================
    // MARK: - PROPERTIES
    // ==================
    
    @IBOutlet weak var newsCollectionView: UICollectionView!
    
    
    // =================
    // MARK: - LIFECYCLE
    // =================

    override func viewDidLoad() {
        super.viewDidLoad()
        
        newsCollectionView.delegate = self
        newsCollectionView.dataSource = self
        
        getEtherNews()

        // Do any additional setup after loading the view.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    
    // ======================
    // MARK: - COLLECTIONVIEW
    // ======================
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("NewsCell", forIndexPath: indexPath)
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 115)
    }
    
    
    // ====================
    // MARK: - INTERACTIONS
    // ====================

    @IBAction func closeXButtonTapped(sender: UIButton) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    
    func getEtherNews() {
        
        ETDataManager.getEtherNewsFromUrlWithSuccess { (data) -> Void in
//            var jsonpString: String = String(data: data, encoding: NSUTF8StringEncoding)!
//            print(jsonpString)
//            jsonpString = jsonpString.stringByReplacingOccurrencesOfString("\"", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
//            
//            let newStartIndex = jsonpString.startIndex.advancedBy(18)
//            let newEndIndex = jsonpString.endIndex.advancedBy(-2)
//            
//            let jsonString = jsonpString.substringWithRange(newStartIndex..<newEndIndex)
//            
//            print(jsonString)
            
            
            var json: [String: AnyObject]!
            
                        
            do {
                json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions()) as? [String: AnyObject]
            } catch {
                print(error)
            }
            
            print(json)
//
//            guard let etherData = EtherInfo(json: json) else {
//                print("Error initializing object")
//                return
//            }
//            
//            guard let etherPrice = etherData.price else {
//                print("No such item")
//                return
//            }
//            
//            self.etherPrices = etherData
//            
//            let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
//            dispatch_async(dispatch_get_global_queue(priority, 0)) {
//                // do some task
//                let priceToBeDisplayed = String(format: "%.3f", etherPrice.btc!)
//                
//                dispatch_async(dispatch_get_main_queue()) {
//                    // update some UI
//                    self.etherPriceLabel.text = "1 eth = \(priceToBeDisplayed) BTC"
//                }
//            }
            
        }
        
    }


}
