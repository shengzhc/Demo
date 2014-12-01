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
}