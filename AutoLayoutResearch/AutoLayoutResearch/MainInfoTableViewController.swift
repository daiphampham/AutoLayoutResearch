//
//  MainInfoTableViewController.swift
//  AutoLayoutResearch
//
//  Created by Quoc Nguyen on 11/27/15.
//  Copyright © 2015 QuocNguyen. All rights reserved.
//

import UIKit
import SDWebImage

class MainInfoTableViewController: UITableViewController {

    var data = [NSDictionary]()
    var sizingCell : MainInfoTableViewCell?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Staff"
        self.prepareData()
    }

    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func prepareData() {
        let dataPath : String? = NSBundle.mainBundle().pathForResource("Data", ofType: "plist")
        guard (dataPath != nil) else {
            return;
        }
        let dataArray = NSArray(contentsOfFile: dataPath!)
        guard (dataArray?.count > 0) else {
            return
        }
        self.data = dataArray as! [NSDictionary]
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.data.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : MainInfoTableViewCell = tableView.dequeueReusableCellWithIdentifier("MainInfoTableViewCell", forIndexPath: indexPath) as! MainInfoTableViewCell
        let info : NSDictionary = self.data[indexPath.row]
        cell.layoutMargins = UIEdgeInsetsZero
        self.setupCellWithDictionary(cell, info: info)
        return cell
    }

    func setupCellWithDictionary(cell : MainInfoTableViewCell, info : NSDictionary) {
        cell.nameLabel.text = info.valueForKey("name") as? String
        cell.positionLabel.text = info.valueForKey("position") as? String
        cell.noteLabel.text = info.valueForKey("note") as? String
        let imageURLString = info.valueForKey("image_info") as? String
        if imageURLString != nil {
            cell.avatarImageView.sd_setImageWithURL(NSURL(string: imageURLString!))
        }
    }

    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if cell.respondsToSelector("setSeparatorInset:") {
            cell.separatorInset = UIEdgeInsetsZero
        }
        if cell.respondsToSelector("setPreservesSuperviewLayoutMargins:") {
            cell.preservesSuperviewLayoutMargins = false
        }
        if cell.respondsToSelector("setLayoutMargins:") {
            cell.layoutMargins = UIEdgeInsetsZero
        }
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if (self.sizingCell == nil) {
            self.sizingCell = tableView.dequeueReusableCellWithIdentifier("MainInfoTableViewCell")
                as? MainInfoTableViewCell
        }
        let info : NSDictionary = self.data[indexPath.row]
        self.setupCellWithDictionary(self.sizingCell!, info: info)
        self.sizingCell?.setNeedsLayout()
        self.sizingCell?.layoutIfNeeded()
        let bestCellHeight : CGFloat = (self.sizingCell?.contentView
            .systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height)!
        let separatorLineHeight : CGFloat = 1.0
        return bestCellHeight + separatorLineHeight
    }

}
