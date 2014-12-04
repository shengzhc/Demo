//
//  Demo_SCChatbubbleViewController.swift
//  DemoApp
//
//  Created by Shengzhe Chen on 12/3/14.
//  Copyright (c) 2014 Shengzhe Chen. All rights reserved.
//

import UIKit

class Demo_SCChatbubbleViewController: SCChatBubbleViewController
{
    @IBOutlet weak var segment: UISegmentedControl!
    var isTracking = false
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
    }
    
    override func targetAtPoint(point: CGPoint, direction: SCChatBubbleView.ArrowDirection)
    {
        var label = UILabel()
        label.textColor = ColorPalate.DarkFuji.color
        label.font = UIFont(name: "AvenirNextCondensed-Regular", size: 16.0)
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.Center
        
        if point.x > self.view.frame.size.width * 0.3 && point.x < self.view.frame.size.width * 0.7 {
            label.text = "I am a very very very long string I am a very very very long string"
        } else if point.x < self.view.frame.size.width * 0.3 {
            label.text = "I am a short left string"
        } else {
            label.text = "I am a short right string"
        }
        var size = label.sizeThatFits(CGSizeMake(200, 100000))
        label.frame.size = CGSizeMake(200, size.height)
        self.setContentView(label)
        
        super.targetAtPoint(point, direction: direction)
        
        var frame = self.bubbleView.frame
        frame.origin.y = self.view.bounds.size.height/2.0 - self.bubbleView.frame.size.height
        self.bubbleView.frame.origin.y = self.view.bounds.size.height/2.0 - self.bubbleView.frame.size.height
        
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent)
    {
        isTracking = true
        self.bubbleView.hidden = false
        
        if let touch = touches.anyObject() as? UITouch {
            var location = touch.locationInView(self.view)
            var direction: SCChatBubbleView.ArrowDirection = .Down
            switch self.segment.selectedSegmentIndex {
            case 0:
                direction = .Up
            case 1:
                direction = .Down
            case 2:
                direction = .Left
            case 3:
                direction = .Right
            default:
                direction = .Down
            }
            
            self.targetAtPoint(location, direction: direction)
        }
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent)
    {
        if let touch = touches.anyObject() as? UITouch {
            var location = touch.locationInView(self.view)
            var direction: SCChatBubbleView.ArrowDirection = .Down
            switch self.segment.selectedSegmentIndex {
            case 0:
                direction = .Up
            case 1:
                direction = .Down
            case 2:
                direction = .Left
            case 3:
                direction = .Right
            default:
                direction = .Down
            }
            self.targetAtPoint(location, direction: direction)
        }
    }
    
    override func touchesCancelled(touches: NSSet!, withEvent event: UIEvent!)
    {
        isTracking = false
        self.bubbleView.hidden = true
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent)
    {
        isTracking = false
        self.bubbleView.hidden = true
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        self.title = "Demo SCChatBubbleViewController"
    }
}