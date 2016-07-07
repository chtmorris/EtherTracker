//
//  ETNewsViewController.swift
//  Ether Tracker
//
//  Created by Charlie Morris on 04/06/2016.
//  Copyright © 2016 Mind Fund Studio. All rights reserved.
//

import UIKit

class ETNewsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, Dimmable, ETWebsiteViewControllerDelegate {
    
    
    // ==================
    // MARK: - PROPERTIES
    // ==================
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var blackBottomGradientView: UIView!
    @IBOutlet weak var closeXButton: UIButton!
    
    var etherNews: [EtherNewsFeedArticles]! = []
    var websiteURL: String!
    let bottomGradientLayer = CAGradientLayer()
    var restingCloseXPosition: CGFloat?
    var refreshControl: UIRefreshControl!

    // =================
    // MARK: - LIFECYCLE
    // =================

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        refreshNewsFeed("")
        addBottomGradientLayer()
        
        self.navigationController?.navigationBarHidden = true
        
    }
    
    override func viewDidAppear(animated: Bool) {
        self.restingCloseXPosition = closeXButton.frame.origin.x
        getEtherNews()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
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
            UIView.animateWithDuration(0.5, animations: {
                self.closeXButton.alpha = 0
                self.collectionView.alpha = 0
            })
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "showWebsite") {
            dim(.In, alpha: 0.5, speed: 0.5)
            let nextVC = segue.destinationViewController as! ETWebsiteViewController
            nextVC.websiteURL = self.websiteURL
            nextVC.delegate = self
        }
    }
    
    func isDismissed() {
        dim(.Out, speed: 0.5)
        UIView.animateWithDuration(0.5, animations: {
            self.closeXButton.alpha = 1
            self.collectionView.alpha = 1
        })
    }

    
    // =======================
    // MARK: - GRADIENT LAYERS
    // =======================
    
    func addBottomGradientLayer() {
        bottomGradientLayer.frame = blackBottomGradientView.bounds
        
        let color1 = UIColor.blackColor().CGColor as CGColorRef
        let color2 = UIColor.blackColor().CGColor as CGColorRef
        let color3 = UIColor.clearColor().CGColor as CGColorRef
        bottomGradientLayer.colors = [color3, color2, color1]
        
        bottomGradientLayer.locations = [0.0, 0.3, 1.0]
        
        blackBottomGradientView.layer.addSublayer(bottomGradientLayer)
    }
    
    
    // ====================
    // MARK: - INTERACTIONS
    // ====================

    @IBAction func closeXButtonTapped(sender: UIButton) {
//        navigationController?.popViewControllerAnimated(true)
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0 {
            self.closeXButton.frame.origin.x = restingCloseXPosition! + (scrollView.contentOffset.y / 10)
        }
    }
    
    @IBAction func handleLeftEdgeSwipeGesture(gestureRecognizer: UIScreenEdgePanGestureRecognizer) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    
    // ========================
    // MARK: - HELPER FUNCTIONS
    // ========================
    
    func startSpinner(){
        // Start spinner - need this to make it white
        if self.collectionView.contentOffset.y == 0 {
            self.collectionView.contentOffset = CGPointMake(0, -self.refreshControl.frame.size.height)
            refreshControl.beginRefreshing()
        }
    }


}


