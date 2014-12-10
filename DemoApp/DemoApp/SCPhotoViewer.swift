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
    private var _prevBounds = CGRectZero

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
        self.backgroundColor = UIColor.redColor()
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
        self.align(center: location, scale: scalor)
    }
    
    public func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView?
    {
        return self.imageView
    }
    
    public func scrollViewDidZoom(scrollView: UIScrollView)
    {
        self.alignContent()
    }
    
    public override func layoutSubviews()
    {
        super.layoutSubviews()
        self.align()
    }
    
    public func align(#center: CGPoint, scale: CGFloat)
    {
        var zoom_rect = CGRectMake(0, 0, self.bounds.size.width/scale, self.bounds.size.height/scale)
        zoom_rect.origin.x = center.x - zoom_rect.size.width/2.0
        zoom_rect.origin.y = center.y - zoom_rect.size.height/2.0
        self.zoomToRect(zoom_rect, animated: true)
    }
    
    private func align()
    {
        if let image = self.imageView.image {
            if self._prevBounds != self.frame {
                var size = self.imageView.frame.size
                var scalor = min(self.bounds.size.width/image.size.width, self.bounds.size.height/image.size.height)
                self.setImage(image)
                if scalor > 0 {
                    var newZoomScale = size.width/image.size.width/scalor
                    self.zoomScale = min(self.maximumZoomScale, max(self.minimumZoomScale, newZoomScale))
                    var minSize = CGSizeMake(image.size.width * scalor, image.size.height * scalor)
                    var maxSize = CGSizeMake(minSize.width * self.maximumZoomScale, minSize.height * self.maximumZoomScale)
                    var width = size.width < minSize.width ? minSize.width : (size.width > maxSize.width ? maxSize.width : size.width)
                    var height = width * image.size.height / image.size.width
                    self.imageView.frame = CGRectMake(0, 0, width, height)
                }
            }
            self.alignContent()
        }
        self._prevBounds = self.frame
    }
    
    public func alignContent()
    {
        var frame = self.imageView.frame
        self.contentSize = frame.size
        var left = max((self.bounds.size.width - frame.width) * 0.5, 0)
        var top = max((self.bounds.size.height - frame.height) * 0.5, 0)
        self.imageView.frame = CGRectMake(left, top, frame.size.width, frame.size.height)
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
        self._prevBounds = CGRectZero
        self.zoomScale = 1.0
        self.minimumZoomScale = 1.0
        self.maximumZoomScale = 3.0
        self.bouncesZoom = true
        self.imageView.transform = CGAffineTransformIdentity
        self.contentSize = self.bounds.size
        self.contentOffset = CGPointZero
    }
}

public class SCImageViewerCell: UICollectionViewCell
{
    var imageView = SCZoomingImageView()
    public override func prepareForReuse()
    {
        super.prepareForReuse()
        self.imageView.reset()
    }
    
    public func setupImage(image: UIImage)
    {
        if self.imageView.superview == nil {
            self.contentView.addSubview(self.imageView)
        }
        self.imageView.setImage(image)
    }
    
    public override func layoutSubviews()
    {
        super.layoutSubviews()
        self.imageView.frame = self.contentView.bounds
    }
}

public class SCImageViewer: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    var collectionView: UICollectionView!
    var flowLayout: UICollectionViewFlowLayout!

    public override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.flowLayout = UICollectionViewFlowLayout()
        self.flowLayout.scrollDirection = .Horizontal
        self.flowLayout.minimumInteritemSpacing = 0
        self.flowLayout.minimumLineSpacing = 0
        self.flowLayout.sectionInset = UIEdgeInsetsZero

        self.collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: self.flowLayout)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.registerClass(SCImageViewerCell.self, forCellWithReuseIdentifier: "Cell")
        self.collectionView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.collectionView.pagingEnabled = true
        
        self.view.addSubview(self.collectionView)
        let views = ["v": self.collectionView]
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[v]|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[v]|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
    }
    
    public override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        UIApplication.sharedApplication().setStatusBarHidden(animated, withAnimation: .Fade)
    }
    
    public override func viewWillDisappear(animated: Bool)
    {
        super.viewWillDisappear(animated)
        UIApplication.sharedApplication().setStatusBarHidden(animated, withAnimation: .Fade)
    }
    
    public override func viewWillLayoutSubviews()
    {
        super.viewWillLayoutSubviews()
        self.collectionView.frame = self.view.bounds
        self.collectionView.collectionViewLayout.invalidateLayout()
    }
    
    public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 2
    }
    
    public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as SCImageViewerCell
        if let image = UIImage(named: "image.jpg") {
            cell.setupImage(image)
        }
        return cell
    }
    
    public func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        return self.collectionView.bounds.size
    }
    
    public override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator)
    {
        self.collectionView.collectionViewLayout.invalidateLayout()
        coordinator.animateAlongsideTransition({ (context: UIViewControllerTransitionCoordinatorContext!) -> Void in
        }, completion: { (context: UIViewControllerTransitionCoordinatorContext!) -> Void in
        })
    }
}



