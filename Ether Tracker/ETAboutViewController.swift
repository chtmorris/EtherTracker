//
//  ETAboutViewController.swift
//  Ether Tracker
//
//  Created by Charlie Morris on 01/07/2016.
//  Copyright © 2016 Mind Fund Studio. All rights reserved.
//

import UIKit

class ETAboutViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    @IBAction func closeButtonTapped(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
