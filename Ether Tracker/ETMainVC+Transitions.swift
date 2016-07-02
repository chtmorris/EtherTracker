//
//  ETMainVC+Transitions.swift
//  Ether Tracker
//
//  Created by Charlie Morris on 01/07/2016.
//  Copyright © 2016 Mind Fund Studio. All rights reserved.
//

import UIKit

extension ETMainViewController: UIViewControllerTransitioningDelegate {
    
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

}
