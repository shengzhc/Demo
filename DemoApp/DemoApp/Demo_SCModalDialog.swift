//
//  Demo_SCModalDialog.swift
//  DemoApp
//
//  Created by Shengzhe Chen on 11/30/14.
//  Copyright (c) 2014 Shengzhe Chen. All rights reserved.
//

import Foundation
import UIKit
import SCModalDialog

class Demo_ModalDialogViewController: UIViewController, SCModalDialogPresentationControllerDelegate
{
    lazy var customTransitioningDelegate: Demo_SCModalDialogTransitioningDelegate = {
        var delegation = Demo_SCModalDialogTransitioningDelegate()
        return delegation
    }()
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        self.title = "Demo SCModalDialogViewController"
    }
    
    @IBAction func hitButtonClicked(sender: AnyObject)
    {
        var controller = UIViewController()
        controller.view.backgroundColor = UIColor.whiteColor()
        controller.view.layer.cornerRadius = 5.0
        controller.view.layer.masksToBounds = true
        controller.transitioningDelegate = self.customTransitioningDelegate
        controller.modalPresentationStyle = .Custom
        self.presentViewController(controller, animated: true, completion: nil)
    }
    
    func didDismissEnd(sender: AnyObject?)
    {
        println(__FUNCTION__)
    }
    
    func didPresentationEnd(sender: AnyObject?)
    {
        println(__FUNCTION__)
    }
}

class Demo_SCModalDialogPresentationController: SCModalDialogPresentationController
{
    override func setupCloseButton()
    {
        self.closeButton.setTitle(nil, forState: .Normal)
        self.closeButton.setBackgroundImage(DemoIcons.closeIcon, forState: .Normal)
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
        var presentationController = Demo_SCModalDialogPresentationController(presentedViewController: presented, presentingViewController: presenting)
        if let delegation = presenting as? SCModalDialogPresentationControllerDelegate {
            presentationController.presentationControllerDelegate = delegation
        } else if let delegation = source as? SCModalDialogPresentationControllerDelegate {
            presentationController.presentationControllerDelegate = delegation
        }
        return presentationController
    }
}
