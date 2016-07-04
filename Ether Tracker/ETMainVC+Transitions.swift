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
        
        print("presentingVC is")
        print(presented.restorationIdentifier)
        
        if presented.restorationIdentifier == "news" {
//            flipPresentAnimationController.originFrame = self.view.frame
            return slideRightAnimationController
        } else {
            return slideUpAnimationController
        }
        
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if dismissed.restorationIdentifier == "news" {
//            flipDismissAnimationController.destinationFrame = self.view.frame
            return slideLeftAnimationController
        } else {
            return slideDownAnimationController
        }
        
    }
    
    func interactionControllerForDismissal(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return swipeInteractionController.interactionInProgress ? swipeInteractionController : nil
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

}
