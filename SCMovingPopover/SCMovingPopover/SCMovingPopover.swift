//
//  SCMovingPopover.swift
//  DemoApp
//
//  Created by Shengzhe Chen on 12/3/14.
//  Copyright (c) 2014 Shengzhe Chen. All rights reserved.
//

import UIKit

public class SCMovingPopover: UIViewController
{
    public var contentMaxWidth: CGFloat = 100
    public var blockMarginEdgeInsets = UIEdgeInsetsMake(150, 10, 100, 10)
    
    public lazy var popoverView: SCMovingPopoverView = {
        var contentView = UIView(frame: CGRectMake(0, 0, 100, 60))
        contentView.backgroundColor = UIColor.redColor()
        return SCMovingPopoverView(contentView: contentView)
    }()
    
    public var arrowDirection: SCMovingPopoverView.ArrowDirection {
        set {self.popoverView.arrowDirection = newValue}
        get {return self.popoverView.arrowDirection}
    }

    public var arrowWidth: CGFloat {
        set {self.popoverView.arrowWidth = newValue}
        get {return self.popoverView.arrowWidth}
    }
    
    public var arrowHeight: CGFloat {
        set {self.popoverView.arrowHeight = newValue}
        get {return self.popoverView.arrowHeight}
    }
    
    public var marginEdgeInsets: UIEdgeInsets {
        set {self.popoverView.marginEdgeInsets = newValue}
        get {return self.popoverView.marginEdgeInsets}
    }
    
    public var paddingEdgeInsets: UIEdgeInsets {
        set {self.popoverView.paddingEdgeInsets = newValue}
        get {return self.popoverView.paddingEdgeInsets}
    }
    
    public var cornerPadding: CGFloat {
        set {self.popoverView.cornerPadding = newValue}
        get {return self.popoverView.cornerPadding}
    }
    
    public var cornerRadius: CGFloat {
        set {self.popoverView.cornerRadius = newValue}
        get {return self.popoverView.cornerRadius}
    }
    
    public var fillColor: UIColor {
        set {self.popoverView.fillColor = newValue}
        get {return self.popoverView.fillColor}
    }
    
    public var strokeColor: UIColor {
        set {self.popoverView.strokeColor = newValue}
        get {return self.popoverView.strokeColor}
    }

    public override func loadView()
    {
        super.loadView()
        self.view.backgroundColor = UIColor.clearColor()
        self.popoverView.hidden = true
        self.view.addSubview(self.popoverView)
    }

    public func targetAtPoint(target: CGPoint)
    {
        self.popoverView.hidden = false
        var origin = self.popoverView.frame.origin
        switch self.arrowDirection {
        case .Up, .Down:
            origin.x = max(self.blockMarginEdgeInsets.left, target.x - self.popoverView.bounds.width/2.0)
            origin.x = min(self.view.bounds.size.width - self.blockMarginEdgeInsets.right - self.popoverView.bounds.size.width, origin.x)
            origin.y = target.y + (self.arrowDirection == .Up ? 0 : -1) * self.popoverView.bounds.size.height
        case .Left, .Right:
            origin.y = max(self.blockMarginEdgeInsets.top, target.y - self.popoverView.bounds.height/2.0)
            origin.y = min(self.view.bounds.size.height - self.blockMarginEdgeInsets.bottom - self.popoverView.bounds.size.height, origin.y)
            origin.x = target.x + (self.arrowDirection == .Left ? 0 : -1) * self.popoverView.bounds.size.width
        }
        self.popoverView.frame.origin = origin

        var arrowPoint = CGPointZero
        switch self.arrowDirection {
        case .Up:
            arrowPoint = CGPointMake(target.x - self.popoverView.frame.origin.x + self.popoverView.marginEdgeInsets.left, self.popoverView.marginEdgeInsets.top)
        case .Down:
            arrowPoint = CGPointMake(target.x - self.popoverView.frame.origin.x + self.popoverView.marginEdgeInsets.left, self.popoverView.frame.size.height - self.popoverView.marginEdgeInsets.bottom)
        case .Left:
            arrowPoint = CGPointMake(self.popoverView.marginEdgeInsets.left, target.y - self.popoverView.frame.origin.y + self.popoverView.marginEdgeInsets.top)
        case .Right:
            arrowPoint = CGPointMake(self.popoverView.frame.size.width - self.popoverView.marginEdgeInsets.right, target.y - self.popoverView.frame.origin.y + self.popoverView.marginEdgeInsets.top)
        }
        
        self.popoverView.setArrowPoint(arrowPoint: arrowPoint)
    }

    public func setContentView(contentView: UIView)
    {
        var size = contentView.sizeThatFits(CGSizeMake(self.contentMaxWidth, 9999))
        contentView.frame.size = CGSizeMake(self.contentMaxWidth, size.height)
        self.popoverView.contentView = contentView
    }
}


public class SCMovingPopoverView: UIView
{
    public enum ArrowDirection
    {
        case Up, Down, Left, Right
    }
    
    private var _boxShapeLayer: CAShapeLayer?
    private var _arrowShapeLayer: CAShapeLayer?
    
    var arrowDirection: ArrowDirection = .Down
    var arrowWidth: CGFloat = 10.0
    var arrowHeight: CGFloat = 20.0
    var marginEdgeInsets = UIEdgeInsetsMake(1.0, 2.0, 1.0, 2.0)
    var paddingEdgeInsets = UIEdgeInsetsMake(5.0, 10.0, 5.0, 10.0)
    var cornerPadding: CGFloat = 12.0
    var cornerRadius: CGFloat = 6.0
    var fillColor: UIColor = UIColor.whiteColor()
    var strokeColor: UIColor = UIColor.blackColor()
    
    private var arrowPoint: CGPoint = CGPointMake(40, 60)

    var contentView: UIView! {
        willSet {
            self.contentView.removeFromSuperview()
        }
        didSet {
            self.contentView.layer.zPosition = 999
            var size = self.contentView.bounds.size
            size.width += (self.paddingEdgeInsets.left + self.paddingEdgeInsets.right + self.marginEdgeInsets.left + self.marginEdgeInsets.right)
            size.height += (self.paddingEdgeInsets.top + self.paddingEdgeInsets.bottom + self.marginEdgeInsets.top + self.marginEdgeInsets.bottom)
            switch self.arrowDirection {
            case .Up, .Down:
                size.height += self.arrowHeight
            case .Left, .Right:
                size.width += self.arrowHeight
            }
            
            self.frame.size = size
            self.addSubview(self.contentView)
        }
    }
    
    public convenience init(contentView: UIView)
    {
        self.init()
        self.contentView = contentView
        self.contentView.layer.zPosition = 999
        self.addSubview(self.contentView)
        var size = self.contentView.bounds.size
        size.width += (self.paddingEdgeInsets.left + self.paddingEdgeInsets.right + self.marginEdgeInsets.left + self.marginEdgeInsets.right)
        size.height += (self.paddingEdgeInsets.top + self.paddingEdgeInsets.bottom + self.marginEdgeInsets.top + self.marginEdgeInsets.bottom)
        self.frame.size = size
    }
    
    private var boxShapeLayer: CAShapeLayer {
        if _boxShapeLayer == nil {
            _boxShapeLayer = CAShapeLayer()
            _boxShapeLayer?.fillColor = self.fillColor.CGColor
            _boxShapeLayer?.zPosition = 0
            _boxShapeLayer?.strokeColor = self.strokeColor.CGColor
            self.layer.addSublayer(_boxShapeLayer)
        }
        return _boxShapeLayer!
    }
    
    private var arrowShapeLayer: CAShapeLayer {
        if _arrowShapeLayer == nil {
            _arrowShapeLayer = CAShapeLayer()
            _arrowShapeLayer?.fillColor = self.fillColor.CGColor
            _arrowShapeLayer?.strokeColor = self.strokeColor.CGColor
            _arrowShapeLayer?.zPosition = 1
            self.layer.addSublayer(_arrowShapeLayer)
        }
        return _arrowShapeLayer!
    }
    
    public func boxShapePathInRect(#rect: CGRect) -> UIBezierPath
    {
        return UIBezierPath(roundedRect: rect, byRoundingCorners: .AllCorners, cornerRadii: CGSizeMake(self.cornerRadius, self.cornerRadius))
    }
    
    public func arrowShapePath() -> UIBezierPath
    {
        var path = UIBezierPath()
        var point0 = CGPointZero
        var point1 = self.arrowPoint
        var point2 = CGPointZero
        switch (self.arrowDirection) {
        case .Up:
            point0.x = min(max(self.arrowPoint.x - self.arrowWidth, self.marginEdgeInsets.left + self.cornerPadding), self.frame.size.width - self.marginEdgeInsets.right - self.cornerPadding - self.arrowWidth * 2.0)
            point0.y = self.arrowPoint.y + self.arrowHeight + 1
            point2.x = point0.x + self.arrowWidth * 2.0
            point2.y = self.arrowPoint.y + self.arrowHeight + 1
        case .Down:
            point0.x = min(max(self.arrowPoint.x - self.arrowWidth, self.marginEdgeInsets.left + self.cornerPadding), self.frame.size.width - self.marginEdgeInsets.right - self.cornerPadding - self.arrowWidth * 2.0)
            point0.y = self.arrowPoint.y - self.arrowHeight - 1
            point2.x = point0.x + self.arrowWidth * 2.0
            point2.y = self.arrowPoint.y - self.arrowHeight - 1
        case .Left:
            point0.x = self.arrowPoint.x + self.arrowHeight + 1
            point0.y = min(max(self.arrowPoint.y - self.arrowWidth, self.marginEdgeInsets.top + self.cornerPadding), self.frame.size.height - self.marginEdgeInsets.bottom - self.cornerPadding - self.arrowWidth * 2.0)
            point2.x = self.arrowPoint.x + self.arrowHeight + 1
            point2.y = point0.y + self.arrowWidth * 2.0
        case .Right:
            point0.x = self.arrowPoint.x - self.arrowHeight - 1
            point0.y = min(max(self.arrowPoint.y - self.arrowWidth, self.marginEdgeInsets.top + self.cornerPadding), self.frame.size.height - self.marginEdgeInsets.bottom - self.cornerPadding - self.arrowWidth * 2.0)
            point2.x = self.arrowPoint.x - self.arrowHeight - 1
            point2.y = point0.y + self.arrowWidth * 2.0
        }
        
        path.lineCapStyle = kCGLineCapRound
        path.moveToPoint(point0)
        path.addLineToPoint(point1)
        path.addLineToPoint(point2)
        return path
    }
    
    internal func setArrowPoint(var #arrowPoint: CGPoint)
    {
        switch self.arrowDirection {
        case .Up, .Down:
            arrowPoint.x = min(max(self.marginEdgeInsets.left, arrowPoint.x), self.frame.size.width - self.marginEdgeInsets.right)
        case .Left, .Right:
            arrowPoint.y = min(max(self.marginEdgeInsets.top, arrowPoint.y), self.frame.size.height - self.marginEdgeInsets.bottom)
        }
        self.arrowPoint = arrowPoint;
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.setNeedsLayout()
        })
    }
    
    public override func layoutSubviews()
    {
        var boxFrame = CGRectZero
        switch self.arrowDirection {
        case .Up:
            boxFrame = CGRectMake(self.marginEdgeInsets.left, self.marginEdgeInsets.top + self.arrowHeight, self.bounds.size.width - self.marginEdgeInsets.left - self.marginEdgeInsets.right, self.bounds.size.height - self.marginEdgeInsets.top - self.marginEdgeInsets.bottom - self.arrowHeight)
        case .Down:
            boxFrame = CGRectMake(self.marginEdgeInsets.left, self.marginEdgeInsets.top, self.bounds.size.width - self.marginEdgeInsets.left - self.marginEdgeInsets.right, self.bounds.size.height - self.marginEdgeInsets.top - self.marginEdgeInsets.bottom - self.arrowHeight)
        case .Left:
            boxFrame = CGRectMake(self.marginEdgeInsets.left + self.arrowHeight, self.marginEdgeInsets.top, self.bounds.size.width - self.marginEdgeInsets.left - self.marginEdgeInsets.right - self.arrowHeight, self.bounds.size.height - self.marginEdgeInsets.top - self.marginEdgeInsets.bottom)
        case .Right:
            boxFrame = CGRectMake(self.marginEdgeInsets.left, self.marginEdgeInsets.top, self.bounds.size.width - self.marginEdgeInsets.left - self.marginEdgeInsets.right - self.arrowHeight, self.bounds.size.height - self.marginEdgeInsets.top - self.marginEdgeInsets.bottom)
        }
        self.boxShapeLayer.frame = boxFrame
        self.contentView.frame = UIEdgeInsetsInsetRect(boxFrame, self.paddingEdgeInsets)
        self.arrowShapeLayer.frame = self.bounds
        self.boxShapeLayer.path = self.boxShapePathInRect(rect: self.boxShapeLayer.bounds).CGPath
        self.arrowShapeLayer.path = self.arrowShapePath().CGPath
    }
}
