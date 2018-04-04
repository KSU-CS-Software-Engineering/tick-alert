//
//  SexViewController.swift
//  Tick Alert
//
//  Created by David Freeman on 3/8/18.
//  Copyright © 2018 David Freeman. All rights reserved.
//

import UIKit

class SexViewController: UIViewController {
    
    @IBOutlet var tickImage: UIImageView!
    @IBOutlet var sexLabel: UILabel!
    @IBOutlet var exampleImage: UIImageView!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var maleFemaleSelector: UISegmentedControl!
    @IBOutlet var roundedView: UIView!
    
    var uploadImage: UIImage?
    
    @IBAction func valueChanged(_ sender: Any) {
        switch(maleFemaleSelector.selectedSegmentIndex) {
            case 0:
                sexLabel.text = "MALE"
                descriptionLabel.text = "Scutum extends the entire length of the body"
                exampleImage.image = #imageLiteral(resourceName: "maleTicks.png")
                break
            case 1:
                sexLabel.text = "FEMALE"
                descriptionLabel.text = "Scutum extends 1/3 to 1/2 the length of the body (allows her body to expand with eggs)"
                exampleImage.image = #imageLiteral(resourceName: "femaleTicks.png")
                break
            default:
                break
        }
    }
    
    @objc func nextButtonPressed() {
        let ornationController = storyboard?.instantiateViewController(withIdentifier: "ornation") as! OrnationViewController
        ornationController.uploadImage = tickImage.image
        if(maleFemaleSelector.selectedSegmentIndex == 0) {ornationController.sex = "MALE"}
        else {ornationController.sex = "FEMALE"}
        navigationController?.pushViewController(ornationController, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nextButton = UIBarButtonItem(title: "Next", style: UIBarButtonItemStyle.plain, target: self, action: #selector(nextButtonPressed))
        self.navigationItem.rightBarButtonItem = nextButton
        
        let contextSize: CGSize = uploadImage!.size
        let rect: CGRect = CGRect(origin: CGPoint(x: (contextSize.height - contextSize.width) / 2, y: 0), size: CGSize(width: contextSize.width, height: contextSize.width))
        let imageRef: CGImage = uploadImage!.cgImage!.cropping(to: rect)!
        tickImage.image = UIImage(cgImage: imageRef, scale: uploadImage!.scale, orientation: uploadImage!.imageOrientation)
        
        sexLabel.text = "MALE"
        descriptionLabel.text = "Scutum extends the entire length of the body"
        exampleImage.image = #imageLiteral(resourceName: "maleTicks.png")
        
        roundedView.layer.cornerRadius = 8
        exampleImage.layer.cornerRadius = 8
        maleFemaleSelector.layer.cornerRadius = 8
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
