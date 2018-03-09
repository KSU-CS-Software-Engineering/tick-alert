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
    
    var uploadImage: UIImage?
    
    @IBAction func valueChanged(_ sender: Any) {
        switch(maleFemaleSelector.selectedSegmentIndex) {
            case 0:
                sexLabel.text = "MALE"
                descriptionLabel.text = "For MALES: scutum extends the entire length of the body"
                exampleImage.image = #imageLiteral(resourceName: "male_ticks.png")
                break
            case 1:
                sexLabel.text = "FEMALE"
                descriptionLabel.text = "For FEMALES: scutum extends 1/3 to 1/2 the length of the body (allows her body to expand with eggs)"
                exampleImage.image = #imageLiteral(resourceName: "female_ticks.png")
                break
            default:
                break
        }
    }
    
    @objc func nextButtonPressed() {
        let ornationController = storyboard?.instantiateViewController(withIdentifier: "ornation") as! OrnationViewController
        ornationController.uploadImage = uploadImage
        if(maleFemaleSelector.selectedSegmentIndex == 0) {ornationController.sex = "MALE"}
        else {ornationController.sex = "FEMALE"}
        navigationController?.pushViewController(ornationController, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nextButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(nextButtonPressed))
        self.navigationItem.rightBarButtonItem = nextButton
        
        tickImage.image = uploadImage
        sexLabel.text = "MALE"
        descriptionLabel.text = "For MALES: scutum extends the entire length of the body"
        exampleImage.image = #imageLiteral(resourceName: "male_ticks.png")
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
