//
//  ETWebsiteViewController.swift
//  Ether Tracker
//
//  Created by Charlie Morris on 06/06/2016.
//  Copyright © 2016 Mind Fund Studio. All rights reserved.
//

import UIKit

class ETWebsiteViewController: UIViewController {

    // ==================
    // MARK: - PROPERTIES
    // ==================
    
    @IBOutlet weak var webView: UIWebView!
    var websiteURL: String!

    
    // =================
    // MARK: - LIFECYCLE
    // =================
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print(websiteURL)
        
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
        navigationController?.popViewControllerAnimated(true)
    }

}
