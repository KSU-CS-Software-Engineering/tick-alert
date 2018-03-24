//
//  DistributionMapViewController.swift
//  Tick Alert
//
//  Created by David Freeman on 3/24/18.
//  Copyright © 2018 David Freeman. All rights reserved.
//

import UIKit

class DistributionMapViewController: UIViewController {
    
    var id: Int?
    @IBOutlet var distributionMap: UIImageView!
    
    @IBAction func close(_ sender: Any) {
        self.removeAnimate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showAnimate()
        
        switch(id!) {
            case 0:
                distributionMap.image = #imageLiteral(resourceName: "blacklegged.jpg")
                break
            case 1:
                distributionMap.image = #imageLiteral(resourceName: "americanDog.jpg")
                break
            case 2:
                distributionMap.image = #imageLiteral(resourceName: "loneStar.jpg")
                break
            case 3:
                distributionMap.image = #imageLiteral(resourceName: "brownDog.jpg")
                break
            case 4:
                distributionMap.image = #imageLiteral(resourceName: "rockyMountainWood.jpg")
                break
            default:
                break
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showAnimate() {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
    }
    
    func removeAnimate() {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0
        }, completion:{(finished: Bool) in
            if(finished) {
                self.view.removeFromSuperview()
            }
        })
    }
}
