//
//  CapitulumViewController.swift
//  Tick Alert
//
//  Created by David Freeman on 3/9/18.
//  Copyright © 2018 David Freeman. All rights reserved.
//

import UIKit

class CapitulumViewController: UIViewController {
    
    var uploadImage: UIImage?
    var sex: String?
    var ornation: String?
    
    @IBOutlet var tickImage: UIImageView!
    @IBOutlet var capitulumLabel: UILabel!
    @IBOutlet var exampleImage: UIImageView!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var capitulumSelector: UISegmentedControl!
    @IBOutlet var roundedView: UIView!
    
    @IBAction func indexSelected(_ sender: Any) {
        switch(capitulumSelector.selectedSegmentIndex) {
            case 0:
                capitulumLabel.text = "SHORT"
                exampleImage.image = #imageLiteral(resourceName: "short_capitulum.png")
                descriptionLabel.text = "Mouth similar in length and width"
                break
            case 1:
                capitulumLabel.text = "LONG"
                exampleImage.image = #imageLiteral(resourceName: "long_capitulum.png")
                descriptionLabel.text = "Mouth longer than it is wide"
                break
            default:
                break
        }
    }
    
    @objc func nextButtonPressed() {
        let specieController = storyboard?.instantiateViewController(withIdentifier: "specie") as! UploadViewController
        specieController.uploadImage = uploadImage
        specieController.sex = sex
        specieController.ornation = ornation
        if(capitulumSelector.selectedSegmentIndex == 0) {specieController.capitulum = "SHORT"}
        else {specieController.capitulum = "LONG"}
        navigationController?.pushViewController(specieController, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let nextButton = UIBarButtonItem(title: "Next", style: UIBarButtonItemStyle.plain, target: self, action: #selector(nextButtonPressed))
        self.navigationItem.rightBarButtonItem = nextButton
        
        tickImage.image = uploadImage
        capitulumLabel.text = "SHORT"
        exampleImage.image = #imageLiteral(resourceName: "short_capitulum.png")
        descriptionLabel.text = "Mouth similar in length and width"
        
        roundedView.layer.cornerRadius = 8
        exampleImage.layer.cornerRadius = 8
        capitulumSelector.layer.cornerRadius = 8
        roundedView.layer.masksToBounds = true
        exampleImage.layer.masksToBounds = true
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
