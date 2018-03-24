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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
