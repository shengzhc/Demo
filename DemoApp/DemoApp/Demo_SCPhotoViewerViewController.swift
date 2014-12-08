//
//  Demo_SCPhotoViewerViewController.swift
//  DemoApp
//
//  Created by Shengzhe Chen on 12/5/14.
//  Copyright (c) 2014 Shengzhe Chen. All rights reserved.
//

import UIKit

class Demo_SCPhotoViewerViewController: SCPhotoViewer
{
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        self.title = "Demo_SCPhotoViewer"
    }
}
