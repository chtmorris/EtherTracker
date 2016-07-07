//
//  ETAboutViewController.swift
//  Ether Tracker
//
//  Created by Charlie Morris on 01/07/2016.
//  Copyright © 2016 Mind Fund Studio. All rights reserved.
//

import UIKit

class ETAboutViewController: UIViewController {

    
    // ==================
    // MARK: - PROPERTIES
    // ==================
    
    @IBOutlet weak var fullScreenView: UIView!
    
    
    // =================
    // MARK: - LIFECYCLE
    // =================
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    
    // ====================
    // MARK: - INTERACTIONS
    // ====================
    
    @IBAction func closeButtonTapped(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func handlePan(recognizer:UIPanGestureRecognizer) {
        let translation = recognizer.translationInView(self.view)
        
        if translation.y > 0 {
            self.fullScreenView.center.y = (view.bounds.height / 2) + translation.y
        }
        
        if translation.y > 30 {
            dismissViewControllerAnimated(true, completion: nil)
        }
        
        switch recognizer.state {
            
        case .Began:
            break
        case .Changed:
            break
        case .Cancelled:
            break
        case .Ended:
            if translation.y > 0 && translation.y < 30 {
                UIView.animateWithDuration(0.5, delay: 0, options: .CurveEaseIn, animations: {
                    self.fullScreenView.center.y = self.view.bounds.height / 2
                    }, completion: nil)
            }
            
        default:
            print("Unsupported")
        }
        
    }

    

}
