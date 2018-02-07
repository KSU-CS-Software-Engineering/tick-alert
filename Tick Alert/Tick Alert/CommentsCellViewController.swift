//
//  CommentsCellViewController.swift
//  Tick Alert
//
//  Created by David Freeman on 2/6/18.
//  Copyright © 2018 David Freeman. All rights reserved.
//

import UIKit

class CommentsCellViewController: UITableViewCell {

    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var commentBody: UILabel!
    @IBOutlet var upvoteButton: UIButton!
    @IBOutlet var downvoteButton: UIButton!
    
    @IBAction func upvoteButtonPressed(_ sender: Any) {
    }
    
    @IBAction func downvoteButtonPressed(_ sender: Any) {
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
