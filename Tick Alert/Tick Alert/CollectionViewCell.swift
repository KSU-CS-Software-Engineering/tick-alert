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
    @IBOutlet var tickImage: UIImageView!
    
    var postId: Int!
    
    // Displays the tick image
    func displayContent(image: UIImage) {
        tickImage.image = image
    }
    
    
    
    
}
