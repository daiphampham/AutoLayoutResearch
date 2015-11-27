//
//  MainInfoTableViewCell.swift
//  AutoLayoutResearch
//
//  Created by Quoc Nguyen on 11/27/15.
//  Copyright © 2015 QuocNguyen. All rights reserved.
//

import UIKit

class MainInfoTableViewCell: UITableViewCell {
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel!

    override func layoutSubviews() {
        super.layoutSubviews()
        updatePreferredMaxLayoutWidth(self.nameLabel)
        updatePreferredMaxLayoutWidth(self.positionLabel)
        updatePreferredMaxLayoutWidth(self.noteLabel)
    }
    func updatePreferredMaxLayoutWidth(label : UILabel) {
        let rightPadding : CGFloat = 8.0;
        label.preferredMaxLayoutWidth = CGRectGetWidth(UIScreen.mainScreen().bounds) - CGRectGetMinX(label.frame) - rightPadding;
    }
}
