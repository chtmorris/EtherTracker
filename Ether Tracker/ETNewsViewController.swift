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
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var etherNews: [EtherNewsFeedArticles]! = []
    var websiteURL: String!
    
    
    // =================
    // MARK: - LIFECYCLE
    // =================

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
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
        return etherNews.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("NewsCell", forIndexPath: indexPath) as? ETNewsArticleCell
        
        cell?.configure(
            title: etherNews[indexPath.row].title!,
            publication: etherNews[indexPath.row].publication!,
            date: etherNews[indexPath.row].date!,
            link: etherNews[indexPath.row].link!
        )

        return cell!
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 115)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if let cell = collectionView.cellForItemAtIndexPath(indexPath) as? ETNewsArticleCell {
            self.websiteURL = cell.urlLink
            self.performSegueWithIdentifier("showWebsite", sender: self)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "showWebsite") {
            let nextVC = segue.destinationViewController as! ETWebsiteViewController
            nextVC.websiteURL = self.websiteURL
        }
    }
        
    
    // ====================
    // MARK: - INTERACTIONS
    // ====================

    @IBAction func closeXButtonTapped(sender: UIButton) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    
    func getEtherNews() {
        
        ETDataManager.getEtherNewsFromUrlWithSuccess { (data) -> Void in
            
            var json: [String: AnyObject]!
            
                        
            do {
                json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions()) as? [String: AnyObject]
            } catch {
                print(error)
            }
            
            guard let etherNews = EtherNewsFeed(json: json) else {
                print("Error initializing object")
                return
            }
            
            guard let newsFeed = etherNews.newsFeed else {
                print("No such item")
                return
            }
            
//            print(newsFeed[0].publication!)
            
            self.etherNews = newsFeed
            
            let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
            dispatch_async(dispatch_get_global_queue(priority, 0)) {
                // do some task
//                let priceToBeDisplayed = String(format: "%.3f", etherPrice.btc!)
                
                dispatch_async(dispatch_get_main_queue()) {
                    // update some UI
                    self.collectionView.reloadData()
                }
            }
            
        }
        
    }


}
