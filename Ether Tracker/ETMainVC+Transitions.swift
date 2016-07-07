//
//  ETMainVC+Transitions.swift
//  Ether Tracker
//
//  Created by Charlie Morris on 01/07/2016.
//  Copyright © 2016 Mind Fund Studio. All rights reserved.
//

import UIKit

extension ETMainViewController: UIViewControllerTransitioningDelegate {
    
    // ============================
    // MARK: - ANIMATING TRANSITION
    // ============================
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if presented.restorationIdentifier == "news" {
            return slideRightAnimationController
        } else {
            return slideUpAnimationController
        }
        
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if dismissed.restorationIdentifier == "news" {
            return slideLeftAnimationController
        } else {
            return slideDownAnimationController
        }
        
    }
    
    
    // ========================
    // MARK: - GESTURE HANDLING
    // ========================
    
    @IBAction func handlePan(recognizer:UIPanGestureRecognizer) {
        let translation = recognizer.translationInView(self.view)
        let etherLogoYPosition:CGFloat = (view.bounds.height) - 60
        
        if translation.y < 0 {
            self.etherLogo.center.y = translation.y + etherLogoYPosition
        }
        
        if translation.y < -30 {
            aboutVCSeen = NSUserDefaults.standardUserDefaults().boolForKey("aboutVCSeen")
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "aboutVCSeen")
            
            performSegueWithIdentifier("showAbout", sender: nil)
        }
        
        switch recognizer.state {
            
        case .Began:
            break
        case .Changed:
            break
        case .Cancelled:
            break
        case .Ended:
            if translation.y < 0 && translation.y > -30 {
                UIView.animateWithDuration(0.5, delay: 0, options: .CurveEaseIn, animations: {
                    self.etherLogo.center.y = etherLogoYPosition
                    }, completion: nil)
            }
            
        default:
            print("Unsupported")
        }
        
    }
    
    @IBAction func handleRightEdgeSwipeGesture(gestureRecognizer: UIScreenEdgePanGestureRecognizer) {
        performSegueWithIdentifier("showNews", sender: nil)
    }

}
