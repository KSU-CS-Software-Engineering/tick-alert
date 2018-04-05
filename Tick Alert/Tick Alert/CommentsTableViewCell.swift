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
        
        roundedView.layer.shadowColor = UIColor.black.cgColor
        roundedView.layer.shadowOpacity = 0.4
        roundedView.layer.shadowOffset = CGSize(width: 0, height: 3)
        roundedView.layer.shadowRadius = 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
