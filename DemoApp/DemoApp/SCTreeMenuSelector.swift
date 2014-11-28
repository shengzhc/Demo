//
//  SCTreeMenuSelector.swift
//  DemoApp
//
//  Created by Shengzhe Chen on 11/25/14.
//  Copyright (c) 2014 Shengzhe Chen. All rights reserved.
//

import Foundation
import UIKit

enum SC_ColorPalate
{
    case LightFuji, Fuji, SemiFuji, DarkFuji
    case LightBamboo, Bamboo, SemiBamboo, DarkBamboo
    case LightWave, Wave, SemiWave, DarkWave
    case LightPebble, Pebble, SemiPebble, DarkPebble
    case LightTempura, Tempura, SemiTempura, DarkTempura
    case LightCoral, Coral, SemiCoral, DarkCoral
    case LightJade, Jade, SemiJade, DarkJade
    case LightBeige, Beige
    
    var color: UIColor {
        get {
            switch self {
            case .LightFuji:
                return UIColor(red: 174.0/255.0, green: 164.0/255.0, blue: 194.0/255.0, alpha: 1.0)
            case .Fuji:
                return UIColor(red: 118.0/255.0, green: 105.0/255.0, blue: 146.0/255.0, alpha: 1.0)
            case .SemiFuji:
                return UIColor(red: 77.0/255.0, green: 63.0/255.0, blue: 108.0/255.0, alpha: 1.0)
            case .DarkFuji:
                return UIColor(red: 60.0/255.0, green: 49.0/255.0, blue: 83.0/255.0, alpha: 1.0)
            case .LightBamboo:
                return UIColor(red: 171.0/255.0, green: 123.0/255.0, blue: 60.0/255.0, alpha: 1.0)
            case .Bamboo:
                return UIColor(red: 141.0/255.0, green: 181.0/255.0, blue: 37.0/255.0, alpha: 1.0)
            case .SemiBamboo:
                return UIColor(red: 105.0/255.0, green: 143.0/255.0, blue: 14.0/255.0, alpha: 1.0)
            case .DarkBamboo:
                return UIColor(red: 83.0/255.0, green: 114.0/255.0, blue: 4.0/255.0, alpha: 1.0)
            case .LightWave:
                return UIColor(red: 118.0/255.0, green: 191.0/255.0, blue: 222.0/255.0, alpha: 1.0)
            case .Wave:
                return UIColor(red: 84.0/255.0, green: 160.0/255.0, blue: 191.0/255.0, alpha: 1.0)
            case .SemiWave:
                return UIColor(red: 26.0/255.0, green: 117.0/255.0, blue: 161.0/255.0, alpha: 1.0)
            case .DarkWave:
                return UIColor(red: 12.0/255.0, green: 84.0/255.0, blue: 121.0/255.0, alpha: 1.0)
            case .LightPebble:
                return UIColor(red: 178.0/255.0, green: 174.0/255.0, blue: 165.0/255.0, alpha: 1.0)
            case .Pebble:
                return UIColor(red: 143.0/255.0, green: 141.0/255.0, blue: 135.0/255.0, alpha: 1.0)
            case .SemiPebble:
                return UIColor(red: 95.0/255.0, green: 91.0/255.0, blue: 85.0/255.0, alpha: 1.0)
            case .DarkPebble:
                return UIColor(red: 67.0/255.0, green: 65.0/255.0, blue: 63.0/255.0, alpha: 1.0)
            case .LightTempura:
                return UIColor(red: 239.0/255.0, green: 168.0/255.0, blue: 94.0/255.0, alpha: 1.0)
            case .Tempura:
                return UIColor(red: 202.0/255.0, green: 120.0/255.0, blue: 40.0/255.0, alpha: 1.0)
            case .SemiTempura:
                return UIColor(red: 158.0/255.0, green: 85.0/255.0, blue: 18.0/255.0, alpha: 1.0)
            case .DarkTempura:
                return UIColor(red: 120.0/255.0, green: 58.0/255.0, blue: 2.0/255.0, alpha: 1.0)
            case .LightCoral:
                return UIColor(red: 240.0/255.0, green: 140.0/255.0, blue: 136.0/255.0, alpha: 1.0)
            case .Coral:
                return UIColor(red: 222.0/255.0, green: 97.0/255.0, blue: 94.0/255.0, alpha: 1.0)
            case .SemiCoral:
                return UIColor(red: 179.0/255.0, green: 45.0/255.0, blue: 44.0/255.0, alpha: 1.0)
            case .DarkCoral:
                return UIColor(red: 147.0/255.0, green: 19.0/255.0, blue: 20.0/255.0, alpha: 1.0)
            case .LightJade:
                return UIColor(red: 135.0/255.0, green: 198.0/255.0, blue: 192.0/255.0, alpha: 1.0)
            case .Jade:
                return UIColor(red: 97.0/255.0, green: 168.0/255.0, blue: 161.0/255.0, alpha: 1.0)
            case .SemiJade:
                return UIColor(red: 49.0/255.0, green: 106.0/255.0, blue: 100.0/255.0, alpha: 1.0)
            case .DarkJade:
                return UIColor(red: 35.0/255.0, green: 87.0/255.0, blue: 82.0/255.0, alpha: 1.0)
            case .LightBeige:
                return UIColor(red: 0.953, green: 0.949, blue: 0.933, alpha: 1.0)
            case .Beige:
                return UIColor(red: 0.898, green: 0.890, blue: 0.867, alpha: 1.0)
            }
        }
    }
}

struct SCTree_MenuItemIcon
{
    static var defaultIcon: UIImage = ({
        var size = CGSizeMake(24, 24)
        var rect = CGRectInset(CGRectMake(0, 0, size.width, size.height), 0.5, 0.5)
        var center = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect))
        let length: CGFloat = rect.width * 0.25
        var bottomCenter = CGPointMake(CGRectGetMidX(rect), 0)
        var topCenter = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect))
        
        UIGraphicsBeginImageContextWithOptions(size, false, 2.0)
        var context = UIGraphicsGetCurrentContext()
        var circle = CGPathCreateWithRoundedRect(rect, rect.size.width/2.0, rect.size.height/2.0, nil)
        var cross = CGPathCreateMutable()
        CGPathMoveToPoint(cross, nil, center.x, center.y-length)
        CGPathAddLineToPoint(cross, nil, center.x, center.y+length)
        CGPathMoveToPoint(cross, nil, center.x-length, center.y)
        CGPathAddLineToPoint(cross, nil, center.x+length, center.y)
        
        CGContextSetStrokeColorWithColor(context, SC_ColorPalate.Bamboo.color.CGColor)
        CGContextAddPath(context, circle)
        CGContextAddPath(context, cross)
        CGContextDrawPath(context, kCGPathStroke)
        let ret = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return ret
    })()
    
    static var rotateIcon: UIImage = ({
        var size = CGSizeMake(24, 24)
        var rect = CGRectInset(CGRectMake(0, 0, size.width, size.height), 0.5, 0.5)
        var center = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect))
        let length: CGFloat = rect.width * 0.25
        var bottomCenter = CGPointMake(CGRectGetMidX(rect), 0)
        var topCenter = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect))
        UIGraphicsBeginImageContextWithOptions(size, false, 2.0)
        var context = UIGraphicsGetCurrentContext()
        var circle = CGPathCreateWithRoundedRect(rect, rect.size.width/2.0, rect.size.height/2.0, nil)
        var cross = CGPathCreateMutable()
        CGPathMoveToPoint(cross, nil, center.x, center.y-length)
        CGPathAddLineToPoint(cross, nil, center.x, center.y+length)
        CGPathMoveToPoint(cross, nil, center.x-length, center.y)
        CGPathAddLineToPoint(cross, nil, center.x+length, center.y)
        

        CGContextSetStrokeColorWithColor(context, SC_ColorPalate.Bamboo.color.CGColor)
        CGContextTranslateCTM(context, center.x, center.y)
        CGContextRotateCTM(context, CGFloat(M_PI_4))
        CGContextTranslateCTM(context, -center.x, -center.y)
        CGContextAddPath(context, circle)
        CGContextAddPath(context, cross)
        CGContextTranslateCTM(context, -size.width/2.0, -size.height/2.0)
        CGContextDrawPath(context, kCGPathStroke)
        let ret = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return ret
    })()
}

enum SCTree_MenuCellIdentifier: String
{
    case MenuItemCellIdentifier = "SCTree_MenuItemCellIdentifier", SubMenuItemCellIdentifier = "SCTree_SubMenuItemCellIdentifier"
}

class SCTree_MenuItem : NSObject, UITableViewDataSource
{
    weak var parent: SCTree_MenuItem?
    var descendents = [SCTree_MenuItem]()
    var text: String = ""
    var isCollapsed = true
    
    var root: SCTree_MenuItem? {
        var parent: SCTree_MenuItem? = self
        while parent?.parent != nil {
            parent = parent?.parent
        }
        return parent
    }
    
    var isRoot: Bool {
        return self.root == self
    }
    
    var depth: Int {
        var parent: SCTree_MenuItem? = self.parent
        var depth = 0
        while parent != nil {
            parent = parent?.parent
            depth++
        }
        return depth
    }
    
    subscript(index: Int) -> SCTree_MenuItem?
    {
        var backwards = self.depth - index
        if backwards < 0 { return nil}
        var ancestor:SCTree_MenuItem? = self
        while backwards-- > 0 {
            ancestor = ancestor?.parent
        }
        return ancestor
    }
    
    convenience init(parent: SCTree_MenuItem?, text:String)
    {
        self.init(text: text)
        self.parent = parent
    }
    
    convenience init(text: String)
    {
        self.init()
        self.text = text
    }
    
    func collapse()
    {
        var list = [SCTree_MenuItem]()
        list.append(self)
        while !list.isEmpty {
            var root = list.removeAtIndex(0)
            root.isCollapsed = true
            for subItem in root.descendents {
                list.append(subItem)
            }
        }
    }
    
    func drillDown()
    {
        self.isCollapsed = false
    }
    
    func menuItemAtIndexPath(indexPath:NSIndexPath) -> SCTree_MenuItem
    {
        if let ancestor = self[indexPath.row] {
            return ancestor
        } else {
            return self.descendents[indexPath.row-self.depth-1]
        }
    }
    
    func indexPathOfMenuItem(menuItem: SCTree_MenuItem) -> NSIndexPath
    {
        var flag = true
        var count = 0
        var p: SCTree_MenuItem? = menuItem

        while p != nil {
            if let parent = p?.parent {
                if let index = find(parent.descendents, p!) { count += index+1 }
            }
            p = p?.parent
        }
        
        return NSIndexPath(forRow: max(0, count-1), inSection: 0)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.descendents.count + self.depth + 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell: SCTree_MenuItemCell?
        
        if !self.isRoot {
            if indexPath.row <= self.depth {
                cell = tableView.dequeueReusableCellWithIdentifier(SCTree_MenuCellIdentifier.MenuItemCellIdentifier.rawValue, forIndexPath: indexPath) as? SCTree_MenuItemCell
            } else {
                cell = tableView.dequeueReusableCellWithIdentifier(SCTree_MenuCellIdentifier.SubMenuItemCellIdentifier.rawValue, forIndexPath: indexPath) as? SCTree_SubMenuItemCell
            }
        } else {
            cell = tableView.dequeueReusableCellWithIdentifier(SCTree_MenuCellIdentifier.MenuItemCellIdentifier.rawValue, forIndexPath: indexPath) as? SCTree_MenuItemCell
        }
        cell?.menuItem = self.menuItemAtIndexPath(indexPath)
        
        if let menuView = tableView as? SCTree_MenuItemCellDelegate {
            cell?.delegate = menuView
        }

        return cell!
    }
}

@objc protocol SCTree_MenuItemCellDelegate : class
{
    optional func menuItemCell(#cell: SCTree_MenuItemCell, didActionButtonClicked sender:AnyObject?)
}

class SCTree_MenuItemCell: UITableViewCell
{
    class CoreGraphicsButton: UIButton
    {
        override func drawRect(var rect: CGRect)
        {
            rect = CGRectInset(rect, 0.5, 0.5)
            var center = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect))
            let length: CGFloat = rect.width * 0.25
            var bottomCenter = CGPointMake(CGRectGetMidX(rect), 0)
            var topCenter = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect))
            
            var context = UIGraphicsGetCurrentContext()
            var circle = CGPathCreateWithRoundedRect(rect, rect.size.width/2.0, rect.size.height/2.0, nil)
            var cross = CGPathCreateMutable()
            CGPathMoveToPoint(cross, nil, center.x, center.y-length)
            CGPathAddLineToPoint(cross, nil, center.x, center.y+length)
            CGPathMoveToPoint(cross, nil, center.x-length, center.y)
            CGPathAddLineToPoint(cross, nil, center.x+length, center.y)
            
            CGContextSetStrokeColorWithColor(context, SC_ColorPalate.Bamboo.color.CGColor)
            CGContextAddPath(context, circle)
            CGContextAddPath(context, cross)
            CGContextDrawPath(context, kCGPathStroke)
        }
        
        func rotateContentLayerToAngle(angle: CGFloat, completionHandler:() -> Void)
        {
            CATransaction.begin()
            var animation = CABasicAnimation(keyPath: "transform.rotation.z")
            animation.toValue = angle
            animation.duration = 0.25
            animation.fillMode = kCAFillModeForwards
            animation.removedOnCompletion = false
            CATransaction.setCompletionBlock(completionHandler)
            self.layer.addAnimation(animation, forKey: "Animation")
            CATransaction.commit()
        }
    }
    
    var menuItemTextLabel: UILabel
    var menuItemSwitchIcon: UIButton
    var seperator: UIView?
    var delegate: SCTree_MenuItemCellDelegate?
    
    var menuItem: SCTree_MenuItem? {
        willSet {
            if let menuItem = newValue {
                if menuItem.isRoot {
                    self.menuItemSwitchIcon.hidden = true
                } else {
                    self.menuItemSwitchIcon.hidden = menuItem.descendents.count <= 0
                }
            }
        }
        didSet {
            self.menuItemTextLabel.text = self.menuItem?.text
            if let menuItem = self.menuItem {
                if menuItem.isCollapsed {
                    self.menuItemSwitchIcon.setBackgroundImage(SCTree_MenuItemIcon.defaultIcon, forState: UIControlState.Normal)
                } else {
                    self.menuItemSwitchIcon.setBackgroundImage(SCTree_MenuItemIcon.rotateIcon, forState: UIControlState.Normal)
                }
            }
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        self.menuItemTextLabel = UILabel()
        self.menuItemTextLabel.font = UIFont(name: "AvenirNextCondensed-Regular", size: 14.0)
        self.menuItemTextLabel.textColor = UIColor.blackColor()
        self.menuItemSwitchIcon = UIButton()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .None
        self.menuItemSwitchIcon.addTarget(self, action: "switchButtonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
        self.menuItemSwitchIcon.setBackgroundImage(SCTree_MenuItemIcon.defaultIcon, forState: .Normal)
        self.contentView.addSubview(self.menuItemTextLabel)
        self.contentView.addSubview(self.menuItemSwitchIcon)
        self.seperator = UIView(); self.seperator?.backgroundColor = SC_ColorPalate.LightFuji.color.colorWithAlphaComponent(0.8)
        self.contentView.addSubview(self.seperator!)
    }
    
    func switchButtonClicked(sender: AnyObject?)
    {
        if let menuItem = self.menuItem {
            var animation = CABasicAnimation(keyPath: "transform.rotation.z")
            animation.duration = 0.25
            animation.fillMode = kCAFillModeForwards
            animation.removedOnCompletion = false
            var completion = {[unowned self] () -> Void in
                self.delegate?.menuItemCell!(cell: self, didActionButtonClicked: sender)
                return
            }

            if menuItem.isCollapsed {
                menuItem.drillDown()
                animation.byValue = M_PI_4
                self.menuItemSwitchIcon.layer.addAnimation(animation, forKey: "Animation")
                CATransaction.commit()
            } else {
                menuItem.collapse()
                animation.byValue = -M_PI_4
            }
            CATransaction.begin()
            CATransaction.setCompletionBlock(completion)
            self.menuItemSwitchIcon.layer.addAnimation(animation, forKey: "Animation")
            CATransaction.commit()
        }
    }

    required init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        self.menuItemTextLabel.sizeToFit()
        self.menuItemTextLabel.frame = CGRectMake(8.0, (self.contentView.bounds.size.height - self.menuItemTextLabel.bounds.size.height)/2.0, self.menuItemTextLabel.bounds.size.width, self.menuItemTextLabel.bounds.size.height)
        let width: CGFloat = 24.0
        self.menuItemSwitchIcon.frame = CGRectMake(self.bounds.size.width - 8.0 - width, (self.contentView.bounds.size.height - width)/2.0, width, width)
        self.seperator?.frame = CGRectMake(0, self.contentView.bounds.size.height - 0.5, self.contentView.bounds.size.width, 0.5)
    }
}

class SCTree_SubMenuItemCell: SCTree_MenuItemCell
{
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = SC_ColorPalate.LightBeige.color
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

class SCTree_MenuView: UITableView, UITableViewDelegate, SCTree_MenuItemCellDelegate
{
    var menuItem: SCTree_MenuItem {
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

    required init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }

    init(menuItem: SCTree_MenuItem)
    {
        self.menuItem = menuItem
        super.init(frame: CGRectZero, style: .Plain)
        self.separatorStyle = .None
        self.dataSource = menuItem
        self.delegate = self
        self.registerClass(SCTree_MenuItemCell.self, forCellReuseIdentifier: SCTree_MenuCellIdentifier.MenuItemCellIdentifier.rawValue)
        self.registerClass(SCTree_SubMenuItemCell.self, forCellReuseIdentifier: SCTree_MenuCellIdentifier.SubMenuItemCellIdentifier.rawValue)
    }
    
    func menuItemCell(#cell: SCTree_MenuItemCell, didActionButtonClicked sender: AnyObject?)
    {
        if let indexPath = self.indexPathForCell(cell) {
            var menuItem = self.menuItem.menuItemAtIndexPath(indexPath)
            if menuItem.isCollapsed {
                menuItem = menuItem.parent ?? menuItem
            }
            self.menuItem = menuItem
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        var menuItem = self.menuItem.menuItemAtIndexPath(indexPath)
        println(menuItem.text)
    }
}

class SCTree_MenuSelector: UIViewController
{
    var tableView: SCTree_MenuView?
    var root: SCTree_MenuItem?
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.redColor()
        self.setupTree()
        self.tableView = SCTree_MenuView(menuItem: (self.root!))
        self.tableView?.frame = self.view.bounds
        self.view.addSubview(self.tableView!)
    }
    
    private func f(raw: [String: AnyObject]) -> SCTree_MenuItem
    {
        var root = SCTree_MenuItem(parent: nil, text: raw["text"] as String)
        var descendents = raw["descendents"] as [[String: AnyObject]]
        for descendent in descendents {
            var subItem = f(descendent)
            subItem.parent = root
            root.descendents.append(subItem)
        }
        return root
    }
    
    func setupTree()
    {
        if let path = NSBundle.mainBundle().pathForResource("menu", ofType: "json") {
            if let jsonData = NSData(contentsOfFile: path) {
                if let jsonObject = NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.AllowFragments, error: nil) as? [String: AnyObject] {
                    self.root = f(jsonObject)
                }
            }
        }
    }
    
}
