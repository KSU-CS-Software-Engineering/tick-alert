//
//  DescriptionViewController.swift
//  Tick Alert
//
//  Created by David Freeman on 3/1/18.
//  Copyright © 2018 David Freeman. All rights reserved.
//

import UIKit

class DescriptionViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var tickType: String?
    var uploadImage: UIImage?
    var sex: String?
    var ornation: String?
    var capitulum: String?
    var locationOptions = ["None of These", "On a Person", "On a Pet", "On Livestock", "On a Wild Animal", "Rural Area", "Urban Area"]
    var location = "None of These"

    @IBOutlet var textField: UITextView!
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return locationOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let attributedString = NSAttributedString(string: locationOptions[row], attributes: [NSAttributedStringKey.foregroundColor : UIColor.white])
        return attributedString
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        location = locationOptions[row]
    }
    
    @objc func nextButtonPressed() {
        let locationController = storyboard?.instantiateViewController(withIdentifier: "Location") as! LocationViewController
        locationController.uploadImage = uploadImage
        locationController.tickType = tickType
        locationController.sex = sex
        locationController.ornation = ornation
        locationController.capitulum = capitulum
        locationController.desc = textField.text
        locationController.whereFound = location
        navigationController?.pushViewController(locationController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nextButton = UIBarButtonItem(title: "Next", style: UIBarButtonItemStyle.plain, target: self, action: #selector(nextButtonPressed))
        self.navigationItem.rightBarButtonItem = nextButton
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
