//
//  SCChatBubbleView.swift
//  DemoApp
//
//  Created by Shengzhe Chen on 12/3/14.
//  Copyright (c) 2014 Shengzhe Chen. All rights reserved.
//

import UIKit

public class SCChatBubbleViewController: UIViewController
{
    public lazy var bubbleView: SCChatBubbleView = {
        var contentView = UIView(frame: CGRectMake(0, 0, 100, 60))
        contentView.backgroundColor = UIColor.redColor()
        return SCChatBubbleView(contentView: contentView)
    }()
    
    public var blockMarginEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10)
    
    public override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clearColor()
        self.bubbleView.hidden = true
        self.view.addSubview(self.bubbleView)
    }
    
    public func targetAtPoint(point: CGPoint, direction: SCChatBubbleView.ArrowDirection = .Down)
    {
        self.bubbleView.hidden = false
        var origin = self.bubbleView.frame.origin
        var size = self.bubbleView.frame.size
        origin.x = max(self.blockMarginEdgeInsets.left, point.x - self.bubbleView.bounds.width/2.0)
        origin.x = min(self.view.bounds.size.width - self.blockMarginEdgeInsets.right - self.bubbleView.bounds.size.width, origin.x)
        self.bubbleView.frame.origin = origin
        self.bubbleView.setArrowPoint(arrowPoint: self.arrowPointAtPoint(point, direction: direction), direction: direction)
    }
    
    public func arrowPointAtPoint(var point: CGPoint, direction: SCChatBubbleView.ArrowDirection) -> CGPoint
    {
        switch direction {
        case .Up:
            point = CGPointMake(point.x - self.bubbleView.frame.origin.x + self.bubbleView.marginEdgeInsets.left, self.bubbleView.marginEdgeInsets.top)
        case .Down:
            point = CGPointMake(point.x - self.bubbleView.frame.origin.x + self.bubbleView.marginEdgeInsets.left, self.bubbleView.frame.size.height - self.bubbleView.marginEdgeInsets.bottom)
        case .Left:
            point = CGPointMake(point.x - self.bubbleView.frame.origin.x + self.bubbleView.marginEdgeInsets.left, self.bubbleView.frame.size.height - self.bubbleView.marginEdgeInsets.bottom)
        case .Right:
            point = CGPointMake(point.x - self.bubbleView.frame.origin.x + self.bubbleView.marginEdgeInsets.left, self.bubbleView.frame.size.height - self.bubbleView.marginEdgeInsets.bottom)
        }
        return point
    }
    
    public func setContentView(contentView: UIView)
    {
        self.bubbleView.contentView = contentView
    }
}


public class SCChatBubbleView: UIView
{
    public enum ArrowDirection
    {
        case Up, Down, Left, Right
    }
    
    private var _boxShapeLayer: CAShapeLayer?
    private var _arrowShapeLayer: CAShapeLayer?
    
    public var arrowDirection: ArrowDirection = .Down
    public var arrowWidth: CGFloat = 10.0
    public var arrowHeight: CGFloat = 20.0
    public var marginEdgeInsets = UIEdgeInsetsMake(1.0, 2.0, 1.0, 2.0)
    public var paddingEdgeInsets = UIEdgeInsetsMake(5.0, 10.0, 5.0, 10.0)
    public var cornerPadding: CGFloat = 12.0
    public var cornerRadius: CGFloat = 6.0
    private var arrowPoint: CGPoint = CGPointMake(40, 60)
    
    public var fillColor: UIColor = UIColor.whiteColor()
    public var strokeColor: UIColor = UIColor.blackColor()
    
    public var contentView: UIView! {
        willSet {
            self.contentView.removeFromSuperview()
        }
        didSet {
            self.contentView.layer.zPosition = 999
            var size = self.contentView.bounds.size
            size.width += (self.paddingEdgeInsets.left + self.paddingEdgeInsets.right + self.marginEdgeInsets.left + self.marginEdgeInsets.right)
            size.height += (self.paddingEdgeInsets.top + self.paddingEdgeInsets.bottom + self.marginEdgeInsets.top + self.marginEdgeInsets.bottom + self.arrowHeight)
            self.frame.size = size
            self.addSubview(self.contentView)
        }
    }
    
    override public init()
    {
        super.init()
    }

    override public init(frame: CGRect)
    {
        super.init(frame: frame)
    }
    
    required public init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    public init(contentView: UIView)
    {
        super.init()
        self.contentView = contentView
        self.contentView.layer.zPosition = 999
        self.addSubview(self.contentView)
        var size = self.contentView.bounds.size
        size.width += (self.paddingEdgeInsets.left + self.paddingEdgeInsets.right + self.marginEdgeInsets.left + self.marginEdgeInsets.right)
        size.height += (self.paddingEdgeInsets.top + self.paddingEdgeInsets.bottom + self.marginEdgeInsets.top + self.marginEdgeInsets.bottom)
        self.frame.size = size
    }
    
    public var boxShapeLayer: CAShapeLayer {
        if _boxShapeLayer == nil {
            _boxShapeLayer = CAShapeLayer()
            _boxShapeLayer?.fillColor = self.fillColor.CGColor
            _boxShapeLayer?.zPosition = 0
            _boxShapeLayer?.strokeColor = self.strokeColor.CGColor
            self.layer.addSublayer(_boxShapeLayer)
        }
        return _boxShapeLayer!
    }
    
    public var arrowShapeLayer: CAShapeLayer {
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
            path.moveToPoint(CGPointMake(self.arrowPoint.x + self.arrowHeight + 1, max(self.arrowPoint.y - self.arrowWidth, self.marginEdgeInsets.bottom)))
            path.addLineToPoint(CGPointMake(self.arrowPoint.x, self.arrowPoint.y))
            path.addLineToPoint(CGPointMake(self.arrowPoint.x + self.arrowHeight + 1, min(self.arrowPoint.y + self.arrowWidth, self.frame.size.height - self.marginEdgeInsets.top)))
        case .Right:
            path.moveToPoint(CGPointMake(self.arrowPoint.x - self.arrowHeight - 1, max(self.arrowPoint.y - self.arrowWidth, self.marginEdgeInsets.bottom)))
            path.addLineToPoint(CGPointMake(self.arrowPoint.x, arrowPoint.y))
            path.addLineToPoint(CGPointMake(self.arrowPoint.x + self.arrowHeight - 1, min(self.arrowPoint.y + self.arrowWidth, self.frame.size.height - self.marginEdgeInsets.top)))
        }
        
        path.lineCapStyle = kCGLineCapRound
        path.moveToPoint(point0)
        path.addLineToPoint(point1)
        path.addLineToPoint(point2)
        return path
    }
    
    public func setArrowPoint(var #arrowPoint: CGPoint, direction: ArrowDirection)
    {
        switch direction {
        case .Up:
            arrowPoint.x = min(max(self.marginEdgeInsets.left, arrowPoint.x), self.frame.size.width - self.marginEdgeInsets.right)
        case .Down:
            arrowPoint.x = min(max(self.marginEdgeInsets.left, arrowPoint.x), self.frame.size.width - self.marginEdgeInsets.right)
        case .Left:
            arrowPoint.x = min(max(self.marginEdgeInsets.left, arrowPoint.x), self.frame.size.width - self.marginEdgeInsets.right)
        case .Right:
            arrowPoint.x = min(max(self.marginEdgeInsets.left, arrowPoint.x), self.frame.size.width - self.marginEdgeInsets.right)
        }
        
        println(arrowPoint)
        
        self.arrowPoint = arrowPoint;
        self.arrowDirection = direction
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
            boxFrame = CGRectMake(self.marginEdgeInsets.left, self.marginEdgeInsets.top, self.bounds.size.width - self.marginEdgeInsets.left - self.marginEdgeInsets.right, self.bounds.size.height - self.marginEdgeInsets.top - self.marginEdgeInsets.bottom - self.arrowHeight)
        case .Right:
            boxFrame = CGRectMake(self.marginEdgeInsets.left, self.marginEdgeInsets.top, self.bounds.size.width - self.marginEdgeInsets.left - self.marginEdgeInsets.right, self.bounds.size.height - self.marginEdgeInsets.top - self.marginEdgeInsets.bottom - self.arrowHeight)
        }
        self.boxShapeLayer.frame = boxFrame
        self.contentView.frame = UIEdgeInsetsInsetRect(boxFrame, self.paddingEdgeInsets)
        self.arrowShapeLayer.frame = self.bounds
        self.boxShapeLayer.path = self.boxShapePathInRect(rect: self.boxShapeLayer.bounds).CGPath
        self.arrowShapeLayer.path = self.arrowShapePath().CGPath
    }
}
