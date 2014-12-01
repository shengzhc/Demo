//
//  Demo_SCModalDialog.swift
//  DemoApp
//
//  Created by Shengzhe Chen on 11/30/14.
//  Copyright (c) 2014 Shengzhe Chen. All rights reserved.
//

import Foundation
import UIKit

class Demo_ModalDialogViewController: UIViewController
{
    lazy var customTransitioningDelegate: Demo_SCModalDialogTransitioningDelegate = {
        var delegation = Demo_SCModalDialogTransitioningDelegate()
        return delegation
    }()
    
    @IBAction func hitButtonClicked(sender: AnyObject)
    {
        var controller = SCModalDialogViewController()
        controller.transitioningDelegate = self.customTransitioningDelegate
        controller.modalPresentationStyle = .Custom
        self.presentViewController(controller, animated: true, completion: nil)
    }
}

class Demo_SCModalDialogPresentationController: SCModalDialogPresentationController
{
    override func setupCloseButton()
    {
        self.closeButton.setTitle(nil, forState: .Normal)
        self.closeButton.setBackgroundImage(DemoIcons.rotateIcon, forState: .Normal)
        self.closeButton.sizeToFit()
    }
    
    override func didCloseButtonClicked(sender: AnyObject?)
    {
        self.presentingViewController.dismissViewControllerAnimated(true, completion: nil)
    }
}

class Demo_SCModalDialogTransitioningDelegate: SCModalDialogTransitioningDelegate
{
    override func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController!, sourceViewController source: UIViewController) -> UIPresentationController?
    {
        return Demo_SCModalDialogPresentationController(presentedViewController: presented, presentingViewController: presenting)
    }
}
