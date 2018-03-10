//
//  UploadViewController.swift
//  Tick Alert
//
//  Created by David Freeman on 2/27/18.
//  Copyright © 2018 David Freeman. All rights reserved.
//

import UIKit
import MapKit
import Firebase

class UploadViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let tickOptions = ["Blacklegged", "Western Blacklegged", "Gulf Coast", "American Dog", "Lone Star", "Brown Dog", "Rocky Mountain Wood"]
    //Images are in same order as options with male followed by female
    let exampleImages = [#imageLiteral(resourceName: "male_blacklegged.png"), #imageLiteral(resourceName: "female_blacklegged.png"), #imageLiteral(resourceName: "male_westernblacklegged.png"), #imageLiteral(resourceName: "female_westernblacklegged.png"), #imageLiteral(resourceName: "male_gulfcoast.png"), #imageLiteral(resourceName: "female_gulfcoast.png"), #imageLiteral(resourceName: "male_americandog.png"), #imageLiteral(resourceName: "female_americandog.png"), #imageLiteral(resourceName: "male_lonestar.png"), #imageLiteral(resourceName: "female_lonestar.png"), #imageLiteral(resourceName: "male_browndog.png"), #imageLiteral(resourceName: "female_browndog.png"), #imageLiteral(resourceName: "male_rockymountainwood.png"), #imageLiteral(resourceName: "female_rockymountainwood.png")]
    let BLACKLEGGED = 0
    let WESTERN_BLACKLEGGED = 1
    let GULF_COAST = 2
    let AMERICAN_DOG = 3
    let LONE_STAR = 4
    let BROWN_DOG = 5
    let ROCKY_MOUNTAIN = 6
    
    var uploadImage: UIImage?
    var sex: String?
    var ornation: String?
    var capitulum: String?
    var selectedTickType: String?
    var options = [Int]()
    
    @IBOutlet var preview: UIImageView!
    @IBOutlet var exampleImage: UIImageView!
    
    @IBAction func identificationTips(_ sender: Any) {
        let commonController = storyboard?.instantiateViewController(withIdentifier: "Common") as! CommonViewController
        navigationController?.pushViewController(commonController, animated: true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return options.count
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let attributedString = NSAttributedString(string: tickOptions[options[row]], attributes: [NSAttributedStringKey.foregroundColor : UIColor.white])
        return attributedString
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedTickType = tickOptions[options[row]]
        if(sex == "MALE") {exampleImage.image = exampleImages[options[row]*2]}
        else {exampleImage.image = exampleImages[options[row]*2+1]}
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        preview.image = uploadImage
        
        if(sex == "MALE") {
            if(ornation == "ORNATE") {
                if(capitulum == "SHORT") {
                    //MALE, ORNATE, SHORT
                    options.append(AMERICAN_DOG)
                    options.append(ROCKY_MOUNTAIN)
                } else {
                    //MALE, ORNATE, LONG
                    options.append(GULF_COAST)
                }
            } else {
                if(capitulum == "SHORT") {
                    //MALE, INORNATE, SHORT
                    options.append(BLACKLEGGED)
                    options.append(WESTERN_BLACKLEGGED)
                    options.append(BROWN_DOG)
                } else {
                    //MALE, INORNATE, LONG
                    options.append(LONE_STAR)
                }
            }
        } else {
            if(ornation == "ORNATE") {
                if(capitulum == "SHORT") {
                    //FEMALE, ORNATE, SHORT
                    options.append(AMERICAN_DOG)
                    options.append(ROCKY_MOUNTAIN)
                } else {
                    //FEMALE, ORNATE, LONG
                    options.append(LONE_STAR)
                    options.append(GULF_COAST)
                }
            } else {
                if(capitulum == "SHORT") {
                    //FEMALE, INORNATE, SHORT
                    options.append(WESTERN_BLACKLEGGED)
                    options.append(BROWN_DOG)
                } else {
                    //FEMALE, INORNATE, LONG
                    options.append(BLACKLEGGED)
                }
            }
        }
        
        if(sex == "MALE") {exampleImage.image = exampleImages[options[0]*2]}
        else {exampleImage.image = exampleImages[options[0]*2+1]}
        selectedTickType = tickOptions[options[0]]
        
        
        let nextButton = UIBarButtonItem(title: "Next", style: UIBarButtonItemStyle.plain, target: self, action: #selector(nextButtonPressed))
        self.navigationItem.rightBarButtonItem = nextButton
    }
    
    @objc func nextButtonPressed() {
        if(selectedTickType == nil) {return}
        
        let descriptionController = storyboard?.instantiateViewController(withIdentifier: "Description") as! DescriptionViewController
        descriptionController.uploadImage = preview.image
        descriptionController.tickType = selectedTickType
        descriptionController.sex = sex
        descriptionController.ornation = ornation
        descriptionController.capitulum = capitulum
        navigationController?.pushViewController(descriptionController, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
