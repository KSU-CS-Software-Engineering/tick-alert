//
//  CollectionViewCell.swift
//  Tick Alert
//
//  Created by Caullen Sasnett on 2/1/18.
//  Copyright © 2018 David Freeman. All rights reserved.
//

import Foundation
import UIKit

// Custom Class for the CollectionView
class CollectionViewCell: UICollectionViewCell {
    
    //Defines aspects of the cells in profile views
    @IBOutlet var tickImage: UIImageView!
    @IBOutlet var roundedView: UIView!
    
    var postId: Int!
    
    // Displays the tick image
    func displayContent(image: UIImage) {
        tickImage.image = image
    }
    
    
    
    
}
