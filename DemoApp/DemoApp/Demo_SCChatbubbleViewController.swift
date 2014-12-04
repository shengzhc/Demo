//
//  Demo_SCChatbubbleViewController.swift
//  DemoApp
//
//  Created by Shengzhe Chen on 12/3/14.
//  Copyright (c) 2014 Shengzhe Chen. All rights reserved.
//

import UIKit

class Demo_SCChatViewController: UIViewController
{
    @IBOutlet weak var segment: UISegmentedControl!
    var chatBubbleViewController = Demo_SCChatBubbleViewController()
    var label: UILabel!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.addChildViewController(self.chatBubbleViewController)
        self.chatBubbleViewController.willMoveToParentViewController(self)
        self.chatBubbleViewController.view.frame = CGRectMake(0, 150, self.view.bounds.size.width, 600)
        self.view.addSubview(self.chatBubbleViewController.view)
        self.chatBubbleViewController.didMoveToParentViewController(self)
        
        self.label = UILabel()
        self.label.textColor = ColorPalate.DarkFuji.color
        self.label.font = UIFont(name: "AvenirNextCondensed-Regular", size: 16.0)
        self.label.numberOfLines = 0
        self.label.textAlignment = NSTextAlignment.Center
        
        
        switch self.segment.selectedSegmentIndex {
        case 0:
            self.chatBubbleViewController.arrowDirection = .Up
        case 1:
            self.chatBubbleViewController.arrowDirection = .Down
        case 2:
            self.chatBubbleViewController.arrowDirection = .Left
        case 3:
            self.chatBubbleViewController.arrowDirection = .Right
        default:
            self.chatBubbleViewController.arrowDirection = .Down
        }
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        self.title = "Demo SCChatBubbleViewController"
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent)
    {
        self.chatBubbleViewController.view.hidden = false
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
        self.chatBubbleViewController.view.hidden = true
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent)
    {
        self.chatBubbleViewController.view.hidden = true
    }
    
    func operateBubbleWithTouch(touch: UITouch)
    {
        var location = touch.locationInView(self.view)
        var text = ""
        switch self.chatBubbleViewController.arrowDirection {
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
            self.chatBubbleViewController.setContentView(label)
        }
        self.chatBubbleViewController.targetAtPoint(location)
    }
    
    @IBAction func arrowDirectionChanged(sender: AnyObject)
    {
        switch self.segment.selectedSegmentIndex {
        case 0:
            self.chatBubbleViewController.arrowDirection = .Up
        case 1:
            self.chatBubbleViewController.arrowDirection = .Down
        case 2:
            self.chatBubbleViewController.arrowDirection = .Left
        case 3:
            self.chatBubbleViewController.arrowDirection = .Right
        default:
            self.chatBubbleViewController.arrowDirection = .Down
        }
    }
    
}

class Demo_SCChatBubbleViewController: SCChatBubbleViewController
{
    override func targetAtPoint(target: CGPoint)
    {
        super.targetAtPoint(target)
        switch self.arrowDirection {
        case .Up, .Down:
            self.bubbleView.frame.origin.y = self.view.bounds.size.height/2.0 - self.bubbleView.frame.size.height
        case .Left, .Right:
            self.bubbleView.frame.origin.x = self.view.bounds.size.width/2.0 - self.bubbleView.frame.size.width/2.0
        }
    }
}
