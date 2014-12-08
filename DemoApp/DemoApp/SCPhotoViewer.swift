//
//  SCPhotoViewer.swift
//  DemoApp
//
//  Created by Shengzhe Chen on 12/5/14.
//  Copyright (c) 2014 Shengzhe Chen. All rights reserved.
//

import Foundation
import UIKit

public class SCPhotoViewer: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
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
    }
    
    public override func viewWillLayoutSubviews()
    {
        super.viewWillLayoutSubviews()
        self.collectionView.frame = self.view.bounds
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


