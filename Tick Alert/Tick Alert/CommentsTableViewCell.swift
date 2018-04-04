//
//  CommentsTableViewCell.swift
//  Tick Alert
//
//  Created by David Freeman on 3/23/18.
//  Copyright © 2018 David Freeman. All rights reserved.
//

import UIKit

class CommentsTableViewCell: UITableViewCell {

    @IBOutlet var commenterImage: UIImageView!
    @IBOutlet var comment: UILabel!
    @IBOutlet var roundedView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        roundedView.layer.cornerRadius = 8
        
        commenterImage.layer.borderWidth = 1
        commenterImage.layer.masksToBounds = false
        commenterImage.layer.borderColor = UIColor.black.cgColor
        commenterImage.layer.cornerRadius = commenterImage.frame.height/2
        commenterImage.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
