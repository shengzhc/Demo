//
//  SCImageViewer.swift
//  DemoApp
//
//  Created by Shengzhe Chen on 12/5/14.
//  Copyright (c) 2014 Shengzhe Chen. All rights reserved.
//

import Foundation
import UIKit

public class SCZoomingImageView: UIScrollView, UIScrollViewDelegate
{
    private var _imageView = UIImageView()
    private var doubleTapGestureRecognizer: UITapGestureRecognizer?
    private var singleTapGestureRecognizer: UITapGestureRecognizer?
    
    public var imageView: UIImageView {
        get {
            return _imageView
        }
        set {
            _imageView = newValue
        }
    }
    
    public override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.setup()
    }
    
    public override init()
    {
        super.init()
        self.setup()
    }

    required public init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup()
    {
        self.setupContent()
        self.setupGestureRecognizer()
        self.reset()
    }
    
    public func setupContent()
    {
        if self.imageView.superview == nil {
            self.imageView.contentMode = .ScaleToFill
            self.delegate = self
            self.addSubview(self.imageView)
        }
    }
    
    public func setupGestureRecognizer()
    {
        self.singleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: "handleSingleTap:")
        self.doubleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: "handleDoubleTap:")
        
        if let singleTapGestureRecognizer = self.singleTapGestureRecognizer {
            if let doubleTapGestureRecognizer = self.doubleTapGestureRecognizer {
                singleTapGestureRecognizer.numberOfTapsRequired = 1
                doubleTapGestureRecognizer.numberOfTapsRequired = 2
                singleTapGestureRecognizer.requireGestureRecognizerToFail(doubleTapGestureRecognizer)
                self.imageView.userInteractionEnabled = true
                self.imageView.addGestureRecognizer(singleTapGestureRecognizer)
                self.imageView.addGestureRecognizer(doubleTapGestureRecognizer)
            }
        }
    }
    
    public func handleSingleTap(gestureRecognizer: UIGestureRecognizer)
    {
    }
    
    public func handleDoubleTap(gestureRecognizer: UIGestureRecognizer)
    {
        var scalor = self.zoomScale == self.maximumZoomScale ? self.minimumZoomScale : self.maximumZoomScale
        var location = gestureRecognizer.locationInView(self.imageView)
        var zoom_rect = CGRectMake(0, 0, self.bounds.size.width/scalor, self.bounds.size.height/scalor)
        zoom_rect.origin.x = location.x - zoom_rect.size.width/2.0
        zoom_rect.origin.y = location.y - zoom_rect.size.height/2.0
        self.zoomToRect(zoom_rect, animated: true)
    }
    
    public override func layoutSubviews()
    {
        super.layoutSubviews()
    }
    
    public func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView?
    {
        return self.imageView
    }
    
    public func scrollViewDidZoom(scrollView: UIScrollView)
    {
        self.alignContent()
    }
    
    public func alignContent()
    {
        self.contentSize = self.imageView.frame.size
        var left = max((self.bounds.size.width - self.contentSize.width) * 0.5, 0)
        var top = max((self.bounds.size.height - self.contentSize.height) * 0.5, 0)
        self.contentInset = UIEdgeInsetsMake(top, left, top, left)
    }
    
    public func setImage(image: UIImage)
    {
        self.reset()
        self.imageView.image = image
        self.imageView.transform = CGAffineTransformIdentity
        
        var imageSize = image.size
        assert(imageSize.width > 0 && imageSize.height > 0, "ImageSize should be Valid")
        var scalor = min(self.bounds.size.width/imageSize.width, self.bounds.size.height/imageSize.height)
        var frame = CGRectApplyAffineTransform(CGRectMake(0, 0, imageSize.width, imageSize.height), CGAffineTransformMakeScale(scalor, scalor))
        self.imageView.frame = frame
        self.alignContent()
    }
    
    public func reset()
    {
        self.zoomScale = 1.0
        self.minimumZoomScale = 1.0
        self.maximumZoomScale = 3.0
        self.imageView.transform = CGAffineTransformIdentity
        self.contentSize = self.bounds.size
        self.contentOffset = CGPointZero
    }
}


public class SCImageViewer: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    var collectionView: UICollectionView!
    var flowLayout: UICollectionViewFlowLayout!
    
    var imageView = SCZoomingImageView()

    public override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.addSubview(self.imageView)
        
//        self.flowLayout = UICollectionViewFlowLayout()
//        self.flowLayout.scrollDirection = .Horizontal
//        self.flowLayout.minimumInteritemSpacing = 0
//        self.flowLayout.minimumLineSpacing = 0
//        self.flowLayout.sectionInset = UIEdgeInsetsZero
//
//        self.collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: self.flowLayout)
//        self.collectionView.delegate = self
//        self.collectionView.dataSource = self
    }
    
    public override func viewWillLayoutSubviews()
    {
        super.viewWillLayoutSubviews()
        self.imageView.frame = self.view.bounds
        self.imageView.setImage(UIImage(named: "image.jpg")!)
//        self.collectionView.frame = self.view.bounds
    }
    
    public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 0
    }
    
    public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as UICollectionViewCell
        return cell
    }
    
    
    public func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        return CGSizeZero
    }
}



