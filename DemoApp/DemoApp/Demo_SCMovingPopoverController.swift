//
//  Demo_SCMovingPopoverController.swift
//  DemoApp
//
//  Created by Shengzhe Chen on 12/3/14.
//  Copyright (c) 2014 Shengzhe Chen. All rights reserved.
//

import UIKit
import SCMovingPopover

class Demo_SCMovingPopoverController: UIViewController
{
    @IBOutlet weak var segment: UISegmentedControl!
    var movingPopoverViewController = Demo_SCMovingPopoverViewController()
    var label: UILabel!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.addChildViewController(self.movingPopoverViewController)
        self.movingPopoverViewController.willMoveToParentViewController(self)
        self.movingPopoverViewController.view.frame = CGRectMake(0, 150, self.view.bounds.size.width, 600)
        self.view.addSubview(self.movingPopoverViewController.view)
        self.movingPopoverViewController.didMoveToParentViewController(self)
        
        self.label = UILabel()
        self.label.textColor = ColorPalate.DarkFuji.color
        self.label.font = UIFont(name: "AvenirNextCondensed-Regular", size: 16.0)
        self.label.numberOfLines = 0
        self.label.textAlignment = NSTextAlignment.Center
        
        
        switch self.segment.selectedSegmentIndex {
        case 0:
            self.movingPopoverViewController.arrowDirection = .Up
        case 1:
            self.movingPopoverViewController.arrowDirection = .Down
        case 2:
            self.movingPopoverViewController.arrowDirection = .Left
        case 3:
            self.movingPopoverViewController.arrowDirection = .Right
        default:
            self.movingPopoverViewController.arrowDirection = .Down
        }
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        self.title = "Demo SCChatBubbleViewController"
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent)
    {
        self.movingPopoverViewController.view.hidden = false
        if let touch = touches.anyObject() as? UITouch {
            self.operateBubbleWithTouch(touch)
        }
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent)
    {
        if let touch = touches.anyObject() as? UITouch {
            self.operateBubbleWithTouch(touch)
        }
    }
    
    override func touchesCancelled(touches: NSSet!, withEvent event: UIEvent!)
    {
        self.movingPopoverViewController.view.hidden = true
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent)
    {
        self.movingPopoverViewController.view.hidden = true
    }
    
    func operateBubbleWithTouch(touch: UITouch)
    {
        var location = touch.locationInView(self.view)
        var text = ""
        switch self.movingPopoverViewController.arrowDirection {
        case .Up, .Down:
            if location.x > self.view.frame.size.width * 0.3 && location.x < self.view.frame.size.width * 0.7 {
                text = "I am a very very very long string I am a very very very long string"
            } else if location.x < self.view.frame.size.width * 0.3 {
                text = "I am a short left string"
            } else {
                text = "I am a short right string"
            }
        case .Left, .Right:
            if location.y > self.view.frame.size.height * 0.3 && location.y < self.view.frame.size.height * 0.7 {
                text = "I am a very very very long string I am a very very very long string"
            } else if location.y < self.view.frame.size.height * 0.3 {
                text = "I am a short top string"
            } else {
                text = "I am a short bottom string"
            }
        }
        if self.label.text != text {
            self.label.text = text
            self.movingPopoverViewController.setContentView(label)
        }
        self.movingPopoverViewController.targetAtPoint(location)
    }
    
    @IBAction func arrowDirectionChanged(sender: AnyObject)
    {
        switch self.segment.selectedSegmentIndex {
        case 0:
            self.movingPopoverViewController.arrowDirection = .Up
        case 1:
            self.movingPopoverViewController.arrowDirection = .Down
        case 2:
            self.movingPopoverViewController.arrowDirection = .Left
        case 3:
            self.movingPopoverViewController.arrowDirection = .Right
        default:
            self.movingPopoverViewController.arrowDirection = .Down
        }
    }
    
}

class Demo_SCMovingPopoverViewController: SCMovingPopover
{
    override func targetAtPoint(target: CGPoint)
    {
        super.targetAtPoint(target)
        switch self.arrowDirection {
        case .Up, .Down:
            self.popoverView.frame.origin.y = self.view.bounds.size.height/2.0 - self.popoverView.frame.size.height
        case .Left, .Right:
            self.popoverView.frame.origin.x = self.view.bounds.size.width/2.0 - self.popoverView.frame.size.width/2.0
        }
    }
}
