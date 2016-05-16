//
//  ViewController.swift
//  Ether Tracker
//
//  Created by Charlie Morris on 16/05/2016.
//  Copyright © 2016 Mind Fund Studio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    // ==================
    // MARK: - PROPERTIES
    // ==================
    
    @IBOutlet weak var etherLogo: UIImageView!
    @IBOutlet weak var etherPriceLabel: UILabel!
    @IBOutlet weak var topButtons: UIImageView!
    @IBOutlet weak var dailyButton: UIButton!
    @IBOutlet weak var weeklyButton: UIButton!
    @IBOutlet weak var monthlyButton: UIButton!
    
    
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
    }
    
    override func viewDidAppear(animated: Bool) {
       let destinationY:CGFloat = view.bounds.height - 60
        
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
                })
        })
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

