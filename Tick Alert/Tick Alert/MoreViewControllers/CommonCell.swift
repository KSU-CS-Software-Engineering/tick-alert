//
//  CommonCell.swift
//  Tick Alert
//
//  Created by David Freeman on 3/1/18.
//  Copyright © 2018 David Freeman. All rights reserved.
//

import UIKit

class CommonCell: UITableViewCell {

    @IBOutlet var tickType: UILabel!
    @IBOutlet var tickPicture: UIImageView!
    @IBOutlet weak var roundedView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        roundedView.layer.cornerRadius = 8
        roundedView.layer.shadowColor = UIColor.black.cgColor
        roundedView.layer.shadowOpacity = 0.3
        roundedView.layer.shadowOffset = CGSize(width: 3, height: 3)
        roundedView.layer.shadowRadius = 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
