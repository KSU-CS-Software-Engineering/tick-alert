//
//  RecentCellViewController.swift
//  Tick Alert
//
//  Created by David Freeman on 2/1/18.
//  Copyright © 2018 David Freeman. All rights reserved.
//

import UIKit

class RecentCellViewController: UITableViewCell {

    @IBOutlet weak var recentTickImage: UIImageView!
    @IBOutlet weak var recentTick: UILabel!
    @IBOutlet weak var recentLocation: UILabel!
    @IBOutlet weak var recentDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
