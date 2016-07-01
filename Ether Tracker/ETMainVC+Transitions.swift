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
        flipPresentAnimationController.originFrame = self.view.frame
        return flipPresentAnimationController
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        flipDismissAnimationController.destinationFrame = self.view.frame
        return flipDismissAnimationController
    }
    
    func interactionControllerForDismissal(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return swipeInteractionController.interactionInProgress ? swipeInteractionController : nil
    }
}
