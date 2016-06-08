//
//  ETWebsiteViewController.swift
//  Ether Tracker
//
//  Created by Charlie Morris on 06/06/2016.
//  Copyright © 2016 Mind Fund Studio. All rights reserved.
//

import UIKit

protocol ETWebsiteViewControllerDelegate: class {
    func isDismissed()
}

class ETWebsiteViewController: UIViewController {

    // ==================
    // MARK: - PROPERTIES
    // ==================
    
    @IBOutlet weak var webView: UIWebView!
    var websiteURL: String!
    weak var delegate: ETWebsiteViewControllerDelegate?

    
    // =================
    // MARK: - LIFECYCLE
    // =================
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        view.opaque = false
        
        let url = NSURL (string: websiteURL)
        let requestObj = NSURLRequest(URL: url!)
        webView.loadRequest(requestObj)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    
    // ====================
    // MARK: - INTERACTIONS
    // ====================
    
    @IBAction func backButtonTapped(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: {
            self.delegate?.isDismissed()
            print("delegate Called")
        })
    }
    

}
