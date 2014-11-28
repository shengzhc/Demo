//
//  ViewController.swift
//  DemoApp
//
//  Created by Shengzhe Chen on 11/25/14.
//  Copyright (c) 2014 Shengzhe Chen. All rights reserved.
//

import UIKit

class ViewController: UITableViewController
{
    enum DemoRows: String
    {
        case SCTreeMenuSelector = "SCTreeMenuSelectorIdentifier"
        
        static func selectorAtIndex(index: Int) -> String? {
            switch index {
            case 0:
                return DemoRows.SCTreeMenuSelector.rawValue;
            default:
                return nil
            }
        }
    }
    
    let cellIdentifier = "defaultCellIdentifier"

    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        self.title = "Demo"
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as? UITableViewCell
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: cellIdentifier)
            cell?.accessoryType = .DisclosureIndicator
        }
        
        switch indexPath.row {
        case 0:
            cell?.textLabel.text = DemoRows.SCTreeMenuSelector.rawValue
        default:
            break
        }
        
        return cell!
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1;
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if let segueIdentifier = DemoRows.selectorAtIndex(indexPath.row) {
            self.performSegueWithIdentifier(segueIdentifier, sender: nil)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)
        
    }
}

