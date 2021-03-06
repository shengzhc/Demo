//
//  SCModalDialog.swift
//  DemoApp
//
//  Created by Shengzhe Chen on 11/30/14.
//  Copyright (c) 2014 Shengzhe Chen. All rights reserved.
//

import Foundation
import UIKit

@objc public protocol SCModalDialogPresentationControllerDelegate: class
{
    optional func didPresentationEnd(sender: AnyObject?)
    optional func didDismissEnd(sender: AnyObject?)
}

public class SCModalDialogPresentationController: UIPresentationController
{
    public weak var presentationControllerDelegate: SCModalDialogPresentationControllerDelegate?
    lazy var dimmingView: UIView = {
        let view = UIView(frame: self.containerView.bounds)
        view.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.6)
        return view
    }()
    
    public lazy var closeButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: "didCloseButtonClicked:", forControlEvents: .TouchUpInside)
        return button
    }()
    
    public func setupCloseButton()
    {
        self.closeButton.setTitle("Close", forState: .Normal)
        self.closeButton.sizeToFit()
    }
    
    public func didCloseButtonClicked(sender: AnyObject?)
    {
        self.presentingViewController.dismissViewControllerAnimated(true, completion: nil)
    }

    public override func presentationTransitionWillBegin()
    {
        self.dimmingView.alpha = 0.0
        self.containerView.addSubview(self.dimmingView)
        self.containerView.addSubview(self.presentedView())
        if let transitionCoordinator = self.presentingViewController.transitionCoordinator() {
            transitionCoordinator.animateAlongsideTransition({(context: UIViewControllerTransitionCoordinatorContext!) -> Void in
                self.dimmingView.alpha  = 1.0
            }, completion:nil)
        }
    }
    
    public override func presentationTransitionDidEnd(completed: Bool)
    {
        self.setupCloseButton()
        self.closeButton.center = self.presentedView().frame.origin
        self.closeButton.alpha = 0.0
        self.containerView.addSubview(self.closeButton)
        let duration = 0.5
        self.closeButton.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.3, 0.3)
        UIView.animateWithDuration(duration/4.0, delay: 0, options: .CurveLinear, animations: { () -> Void in
            self.closeButton.alpha = 1.0
        }, completion: nil)
        
        UIView.animateWithDuration(duration, delay: 0, usingSpringWithDamping: 0.55, initialSpringVelocity: -5, options: .CurveLinear, animations: { () -> Void in
            self.closeButton.transform = CGAffineTransformIdentity
        }, completion: nil)
        
        self.presentationControllerDelegate?.didPresentationEnd?(nil)
    }
    
    public override func dismissalTransitionWillBegin()
    {
        if let transitionCoordinator = self.presentingViewController.transitionCoordinator() {
            transitionCoordinator.animateAlongsideTransition({ (context: UIViewControllerTransitionCoordinatorContext!) -> Void in
                var duration = context.transitionDuration()
                UIView.animateWithDuration(duration * 0.75, delay: duration * 0.25, options: .CurveLinear, animations: { () -> Void in
                    self.dimmingView.alpha = 0.0
                }, completion: nil)

                UIView.animateWithDuration(duration * 0.1, delay: 0, options: .CurveLinear, animations: { () -> Void in
                    self.closeButton.alpha = 0.0
                }, completion: nil)
            }, completion: nil)
        }
    }
    
    public override func dismissalTransitionDidEnd(completed: Bool)
    {
        if completed {
            self.dimmingView.removeFromSuperview()
            self.closeButton.removeFromSuperview()
            self.presentationControllerDelegate?.didDismissEnd?(nil)
        }
    }
}

public class SCModalDialogTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate
{
    public func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        return SCModalDialogPresentAnimator()
    }

    public func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        return SCModalDialogDismissAnimator()
    }

    public func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController!, sourceViewController source: UIViewController) -> UIPresentationController?
    {
        return SCModalDialogPresentationController(presentedViewController: presented, presentingViewController: presenting)
    }
}

public class SCModalDialogPresentAnimator: NSObject, UIViewControllerAnimatedTransitioning
{
    public var duration = 0.5
    public var edgeInsets = UIEdgeInsetsMake(200.0, 40.0, 200.0, 40.0)
    public var fullScreen = false
    
    public func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval
    {
        return self.duration
    }

    public func animateTransition(transitionContext: UIViewControllerContextTransitioning)
    {
        var toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        var fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        var containerView = transitionContext.containerView()
        var frame = containerView.bounds
        if !self.fullScreen {
            frame = UIEdgeInsetsInsetRect(frame, self.edgeInsets)
        }
        
        toViewController?.view.frame = frame
        containerView.addSubview(toViewController!.view)
        toViewController?.view.alpha = 0.0;
        toViewController?.view.transform = CGAffineTransformMakeScale(0.3, 0.3);
        var duration = self.transitionDuration(transitionContext)

        UIView.animateWithDuration(duration/2.0, animations: { () -> Void in
            toViewController?.view.alpha = 1.0
            return
        })

        var damping: CGFloat = 0.55
        
        UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: damping, initialSpringVelocity: 1.0/damping, options: .CurveLinear, animations: { () -> Void in
            toViewController?.view.transform = CGAffineTransformIdentity
            return
        }, completion: { (finished: Bool) -> Void in
            transitionContext.completeTransition(true)
        })
    }
}

public class SCModalDialogDismissAnimator: NSObject, UIViewControllerAnimatedTransitioning
{
    public var duration = 0.5
    public func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval
    {
        return self.duration
    }
    
    public func animateTransition(transitionContext: UIViewControllerContextTransitioning)
    {
        var toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        var fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        var containerView = transitionContext.containerView()

        UIView.animateWithDuration(3.0 * self.duration / 4.0, delay: duration/4.0, options: .CurveLinear, animations: { () -> Void in
            fromViewController?.view.alpha = 0.0
            return
            }) { (completed: Bool) -> Void in
            fromViewController?.view.removeFromSuperview()
            transitionContext.completeTransition(true)
        }
        
        UIView.animateWithDuration(duration * 2.0, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: -12.0, options: .CurveLinear, animations: { () -> Void in
            fromViewController?.view.transform = CGAffineTransformMakeScale(0.3, 0.3);
            return
            }, completion:nil)
    }
}


