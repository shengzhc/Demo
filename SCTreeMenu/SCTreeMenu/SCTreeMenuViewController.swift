//
//  SCTreeMenuViewController.swift
//  DemoApp
//
//  Created by Shengzhe Chen on 11/29/14.
//  Copyright (c) 2014 Shengzhe Chen. All rights reserved.
//

import Foundation
import UIKit

@objc public protocol SCTreeMenuItemCellDelegate : class
{
    optional func menuItemCell(#cell: SCTreeMenuItemCell, didActionButtonClicked sender:AnyObject?)
}

@objc public protocol SCTreeMenuViewDelegate : class
{
    optional func menuView(#menuView: SCTreeMenuView, didSelectRowAtIndexPath indexPath:NSIndexPath)
}

public class SCTreeMenuItem : NSObject, UITableViewDataSource
{
    weak public var parent: SCTreeMenuItem?
    public var descendents = [SCTreeMenuItem]()
    public var text: String = ""
    public var isCollapsed = true
    
    public var root: SCTreeMenuItem? {
        var parent: SCTreeMenuItem? = self
        while parent?.parent != nil {
            parent = parent?.parent
        }
        return parent
    }
    
    public var isRoot: Bool {
        return self.root == self
    }
    
    public var depth: Int {
        var parent: SCTreeMenuItem? = self.parent
        var depth = 0
        while parent != nil {
            parent = parent?.parent
            depth++
        }
        return depth
    }
    
    public subscript(index: Int) -> SCTreeMenuItem?
        {
            var backwards = self.depth - index
            if backwards < 0 { return nil}
            var ancestor:SCTreeMenuItem? = self
            while backwards-- > 0 {
                ancestor = ancestor?.parent
            }
            return ancestor
    }
    
    public convenience init(parent: SCTreeMenuItem?, text:String)
    {
        self.init(text: text)
        self.parent = parent
    }
    
    public convenience init(text: String)
    {
        self.init()
        self.text = text
    }
    
    public func collapse()
    {
        var list = [SCTreeMenuItem]()
        list.append(self)
        while !list.isEmpty {
            var root = list.removeAtIndex(0)
            root.isCollapsed = true
            for subItem in root.descendents {
                list.append(subItem)
            }
        }
    }
    
    public func drillDown()
    {
        self.isCollapsed = false
    }
    
    public func menuItemAtIndexPath(indexPath:NSIndexPath) -> SCTreeMenuItem
    {
        if let ancestor = self[indexPath.row] {
            return ancestor
        } else {
            return self.descendents[indexPath.row-self.depth-1]
        }
    }
    
    public func indexPathOfMenuItem(menuItem: SCTreeMenuItem) -> NSIndexPath
    {
        var flag = true
        var count = 0
        var p: SCTreeMenuItem? = menuItem
        
        while p != nil {
            if let parent = p?.parent {
                if let index = find(parent.descendents, p!) { count += index+1 }
            }
            p = p?.parent
        }
        
        return NSIndexPath(forRow: max(0, count-1), inSection: 0)
    }
    
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.descendents.count + self.depth + 1
    }
    
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell: SCTreeMenuItemCell = tableView.dequeueReusableCellWithIdentifier("SCTreeMenuItemCellIdentifier", forIndexPath: indexPath) as SCTreeMenuItemCell
        cell.menuItem = self.menuItemAtIndexPath(indexPath)
        return cell
    }
}

public class SCTreeMenuItemCell: UITableViewCell
{
    public var menuItemTextLabel: UILabel
    public var menuItemActionButton: UIButton
    public var seperator: UIView?
    public weak var delegate: SCTreeMenuItemCellDelegate?
    public var menuItem: SCTreeMenuItem?
    
    override public init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        self.menuItemTextLabel = UILabel()
        self.menuItemTextLabel.font = UIFont(name: "AvenirNextCondensed-Regular", size: 14.0)
        self.menuItemTextLabel.textColor = UIColor.blackColor()
        self.menuItemActionButton = UIButton()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .None
        self.menuItemActionButton.addTarget(self, action: "actionButtonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
        self.menuItemActionButton.setTitle("Action", forState: .Normal)
        self.contentView.addSubview(self.menuItemTextLabel)
        self.contentView.addSubview(self.menuItemActionButton)
        self.seperator = UIView(); self.seperator?.backgroundColor = UIColor.blackColor()
        self.contentView.addSubview(self.seperator!)
    }
    
    public func actionButtonClicked(sender: AnyObject?)
    {
        self.delegate?.menuItemCell?(cell: self, didActionButtonClicked: sender)
    }
    
    required public init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func layoutSubviews()
    {
        super.layoutSubviews()
        self.menuItemTextLabel.sizeToFit()
        self.menuItemTextLabel.frame = CGRectMake(8.0, (self.contentView.bounds.size.height - self.menuItemTextLabel.bounds.size.height)/2.0, self.menuItemTextLabel.bounds.size.width, self.menuItemTextLabel.bounds.size.height)
        let width: CGFloat = 24.0
        self.menuItemActionButton.frame = CGRectMake(self.bounds.size.width - 8.0 - width, (self.contentView.bounds.size.height - width)/2.0, width, width)
        self.seperator?.frame = CGRectMake(0, self.contentView.bounds.size.height - 0.5, self.contentView.bounds.size.width, 0.5)
    }
}

public class SCTreeMenuView: UITableView, UITableViewDelegate, SCTreeMenuItemCellDelegate
{
    public weak var menuViewDelegate: SCTreeMenuViewDelegate?
    public var menuItem: SCTreeMenuItem {
        didSet {
            self.dataSource = self.menuItem
            var indexPath = self.menuItem.indexPathOfMenuItem(self.menuItem)
            if self.menuItem.isCollapsed {
                self.reloadSections(NSIndexSet(index: 0), withRowAnimation: UITableViewRowAnimation.Fade)
            } else {
                self.reloadSections(NSIndexSet(index: 0), withRowAnimation: UITableViewRowAnimation.Fade)
            }
        }
    }
    
    required public init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    required public init(menuItem: SCTreeMenuItem)
    {
        self.menuItem = menuItem
        super.init(frame: CGRectZero, style: .Plain)
        self.separatorStyle = .None
        self.dataSource = menuItem
        self.delegate = self
        self.registerClass(SCTreeMenuItemCell.self, forCellReuseIdentifier: "SCTreeMenuItemCellIdentifier")
    }
    
    public func menuItemCell(#cell: SCTreeMenuItemCell, didActionButtonClicked sender: AnyObject?)
    {
        if let indexPath = self.indexPathForCell(cell) {
            var menuItem = self.menuItem.menuItemAtIndexPath(indexPath)
            if menuItem.isCollapsed {
                menuItem = menuItem.parent ?? menuItem
            }
            self.menuItem = menuItem
        }
    }

    public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        self.menuViewDelegate?.menuView?(menuView: self, didSelectRowAtIndexPath: indexPath)
    }
}

public class SCTreeMenuViewController: UIViewController, SCTreeMenuViewDelegate
{
    public var menuView: SCTreeMenuView?
    public var root: SCTreeMenuItem?
    override public func viewDidLoad()
    {
        super.viewDidLoad()
        self.setupTree()
        self.setupMenuView()
    }
    
    override public func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
        self.menuView?.frame = self.view.bounds
    }

    public func menuView(#menuView: SCTreeMenuView, didSelectRowAtIndexPath indexPath: NSIndexPath) {}
    public func setupTree() {}
    
    public func setupMenuView()
    {
        self.menuView = SCTreeMenuView(menuItem: (self.root!))
        self.menuView?.frame = self.view.bounds
        self.view.addSubview(self.menuView!)
        self.menuView?.menuViewDelegate = self
    }
    
}