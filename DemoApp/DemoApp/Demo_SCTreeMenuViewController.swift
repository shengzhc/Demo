//
//  Demo_SCTreeMenuViewController.swift
//  DemoApp
//
//  Created by Shengzhe Chen on 11/29/14.
//  Copyright (c) 2014 Shengzhe Chen. All rights reserved.
//

import Foundation
import UIKit
import SCTreeMenu

enum Demo_SCTreeMenuCellIdentifier: String
{
    case DemoSCMenuItemCellIdentifier = "DemoSCMenuItemCellIdentifier", DemoSCSubMenuItemCellIdentifier = "DemoSCSubMenuItemCellIdentifier"
}

class Demo_SCTreeMenuItem: SCTreeMenuItem
{
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell: SCTreeMenuItemCell?
        if !self.isRoot {
            if indexPath.row <= self.depth {
                cell = tableView.dequeueReusableCellWithIdentifier(Demo_SCTreeMenuCellIdentifier.DemoSCMenuItemCellIdentifier.rawValue, forIndexPath: indexPath) as? Demo_SCTreeMenuItemCell
            } else {
                cell = tableView.dequeueReusableCellWithIdentifier(Demo_SCTreeMenuCellIdentifier.DemoSCSubMenuItemCellIdentifier.rawValue, forIndexPath: indexPath) as? Demo_SCTreeSubMenuItemCell
            }
        } else {
            cell = tableView.dequeueReusableCellWithIdentifier(Demo_SCTreeMenuCellIdentifier.DemoSCMenuItemCellIdentifier.rawValue, forIndexPath: indexPath) as? Demo_SCTreeMenuItemCell
        }
        cell?.menuItem = self.menuItemAtIndexPath(indexPath)
        
        if let menuView = tableView as? SCTreeMenuItemCellDelegate {
            cell?.delegate = menuView
        }
        
        return cell!
    }
}

class Demo_SCTreeMenuItemCell: SCTreeMenuItemCell
{
    override var menuItem: SCTreeMenuItem? {
        willSet {
            if let menuItem = newValue {
                if menuItem.isRoot {
                    self.menuItemActionButton.hidden = true
                } else {
                    self.menuItemActionButton.hidden = menuItem.descendents.count <= 0
                }
            }
        }
        didSet {
            self.menuItemTextLabel.text = self.menuItem?.text
            if let menuItem = self.menuItem {
                if menuItem.isCollapsed {
                    self.menuItemActionButton.setBackgroundImage(DemoIcons.defaultIcon, forState: UIControlState.Normal)
                } else {
                    self.menuItemActionButton.setBackgroundImage(DemoIcons.rotateIcon, forState: UIControlState.Normal)
                }
            }
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.menuItemActionButton.setTitle(nil, forState: .Normal)
        self.menuItemActionButton.setBackgroundImage(DemoIcons.defaultIcon, forState: .Normal)
        self.seperator?.backgroundColor = ColorPalate.LightFuji.color.colorWithAlphaComponent(0.8)
        self.contentView.addSubview(self.seperator!)
    }
    
    override func actionButtonClicked(sender: AnyObject?)
    {
        if let menuItem = self.menuItem {
            var animation = CABasicAnimation(keyPath: "transform.rotation.z")
            animation.duration = 0.1
            animation.fillMode = kCAFillModeForwards
            animation.removedOnCompletion = false
            var completion = {[unowned self] () -> Void in
                self.delegate?.menuItemCell!(cell: self, didActionButtonClicked: sender)
                return
            }
            
            if menuItem.isCollapsed {
                menuItem.drillDown()
                animation.byValue = M_PI_4
                self.menuItemActionButton.layer.addAnimation(animation, forKey: "Animation")
                CATransaction.commit()
            } else {
                menuItem.collapse()
                animation.byValue = -M_PI_4
            }
            CATransaction.begin()
            CATransaction.setCompletionBlock(completion)
            self.menuItemActionButton.layer.addAnimation(animation, forKey: "Animation")
            CATransaction.commit()
        }
   
    }
    
    required init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
}

class Demo_SCTreeSubMenuItemCell: Demo_SCTreeMenuItemCell
{
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = ColorPalate.LightBeige.color
        self.menuItemTextLabel.font = UIFont(name: "AvenirNextCondensed-Regular", size: 12.0)
        self.seperator?.hidden = true
    }
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        self.menuItemTextLabel.frame = CGRectMake(24.0, (self.contentView.bounds.size.height - self.menuItemTextLabel.bounds.size.height)/2.0, self.menuItemTextLabel.bounds.size.width, self.menuItemTextLabel.bounds.size.height)
    }
    
    required init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
}

class Demo_SCTreeMenuView: SCTreeMenuView
{
    required init(menuItem: SCTreeMenuItem)
    {
        super.init(menuItem: menuItem)
        self.registerClass(Demo_SCTreeMenuItemCell.self, forCellReuseIdentifier: Demo_SCTreeMenuCellIdentifier.DemoSCMenuItemCellIdentifier.rawValue)
        self.registerClass(Demo_SCTreeSubMenuItemCell.self, forCellReuseIdentifier: Demo_SCTreeMenuCellIdentifier.DemoSCSubMenuItemCellIdentifier.rawValue)
    }

    required init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
}

class Demo_SCTreeMenuViewController: SCTreeMenuViewController
{
    private func f(raw: [String: AnyObject]) -> SCTreeMenuItem
    {
        var root = Demo_SCTreeMenuItem(parent: nil, text: raw["text"] as String)
        var descendents = raw["descendents"] as [[String: AnyObject]]
        for descendent in descendents {
            var subItem = f(descendent)
            subItem.parent = root
            root.descendents.append(subItem)
        }
        return root
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        self.title = "Demo SCTreeMenuViewController"
    }
    
    override func setupTree()
    {
        if let path = NSBundle.mainBundle().pathForResource("menu", ofType: "json") {
            if let jsonData = NSData(contentsOfFile: path) {
                if let jsonObject = NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.AllowFragments, error: nil) as? [String: AnyObject] {
                    self.root = f(jsonObject)
                }
            }
        }
    }
    
    override func setupMenuView()
    {
        self.menuView = Demo_SCTreeMenuView(menuItem: self.root!)
        self.menuView?.frame = self.view.bounds
        self.view.addSubview(self.menuView!)
        self.menuView?.menuViewDelegate = self
    }
    
    override func menuView(#menuView: SCTreeMenuView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        var menuItem = menuView.menuItem.menuItemAtIndexPath(indexPath) as? Demo_SCTreeMenuItem
        if menuItem != nil {
            self.title = menuItem!.text
        }
    }

}