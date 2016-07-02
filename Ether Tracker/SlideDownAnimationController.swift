//
//  SlideDownAnimationController.swift
//  Ether Tracker
//
//  Created by Charlie Morris on 01/07/2016.
//  Copyright © 2016 Mind Fund Studio. All rights reserved.
//

import UIKit

class SlideDownAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.8
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        let finalFrameForVC = transitionContext.finalFrameForViewController(toViewController!)
        let containerView = transitionContext.containerView()
        let bounds = UIScreen.mainScreen().bounds
        
        toViewController!.view.frame = CGRectOffset(finalFrameForVC, 0, -bounds.size.height)
        containerView?.addSubview((toViewController?.view)!)
        
        UIView.animateWithDuration(transitionDuration(transitionContext), delay: 0.0, usingSpringWithDamping: 0.85, initialSpringVelocity: 0.0, options: .CurveLinear, animations: {
            fromViewController!.view.alpha = 0.5
            toViewController?.view.frame = finalFrameForVC
            fromViewController!.view.frame = CGRectOffset(finalFrameForVC, 0, bounds.size.height)
            
            }, completion: { finished in
                transitionContext.completeTransition(true)
                fromViewController?.view.alpha = 1.0
        })
        
    }

}
