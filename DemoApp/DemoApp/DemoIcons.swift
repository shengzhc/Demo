//
//  DemoIcons.swift
//  DemoApp
//
//  Created by Shengzhe Chen on 11/30/14.
//  Copyright (c) 2014 Shengzhe Chen. All rights reserved.
//

import Foundation
import UIKit

struct DemoIcons
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
        
        CGContextSetStrokeColorWithColor(context, ColorPalate.Bamboo.color.CGColor)
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
        
        
        CGContextSetStrokeColorWithColor(context, ColorPalate.Bamboo.color.CGColor)
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
    
    static var closeIcon: UIImage = ({
        
        var color = ColorPalate.Fuji.color
        var size = CGSizeMake(44.0, 44.0)
        var outerRect = CGRectInset(CGRectMake(0, 0, size.width, size.height), 0.5, 0.5)
        var innerRect = CGRectInset(outerRect, size.height/10.0, size.height/10.0)
        var outerCircle = CGPathCreateWithRoundedRect(outerRect, outerRect.size.width/2.0, outerRect.size.height/2.0, nil)
        var innerCircle = CGPathCreateWithRoundedRect(innerRect, innerRect.size.width/2.0, innerRect.size.height/2.0, nil)
        UIGraphicsBeginImageContextWithOptions(size, false, 2.0)
        var context = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextAddPath(context, outerCircle)
        CGContextFillPath(context)
        
        CGContextSetFillColorWithColor(context, UIColor.whiteColor().CGColor)
        CGContextAddPath(context, innerCircle)
        CGContextFillPath(context)
        
        let length: CGFloat = size.width * 0.3
        let height: CGFloat = size.height/10.0
        let cornerRadius = min(length/2.0, height/2.0)
        var lineRect = CGPathCreateWithRoundedRect(CGRectMake(-length, -height/2.0, length*2, height), cornerRadius, cornerRadius, nil)
        
        var center = CGPointMake(CGRectGetMidX(innerRect), CGRectGetMidY(innerRect))
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, center.x, center.y)
        CGContextRotateCTM(context,CGFloat(M_PI_4))
        CGContextAddPath(context, lineRect)
        CGContextTranslateCTM(context, -center.x, -center.y)
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextFillPath(context)
        
        CGContextRestoreGState(context)
        CGContextTranslateCTM(context, center.x, center.y)
        CGContextRotateCTM(context,CGFloat(-M_PI_4))
        CGContextAddPath(context, lineRect)
        CGContextTranslateCTM(context, -center.x, -center.y)
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextFillPath(context)
        let ret = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return ret
    })()
}