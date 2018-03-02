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
    
    let tickOptions = ["Pick Tick:","Blacklegged Tick", "American Dog Tick", "Lone Star Tick", "Brown Dog Tick", "Rocky Mountain Tick"]
    
    var uploadImage: UIImage?
    var selectedTickType: String?
    
    @IBOutlet var tickType: UITextField!
    @IBOutlet var preview: UIImageView!
    @IBAction func identificationTips(_ sender: Any) {
        let commonController = storyboard?.instantiateViewController(withIdentifier: "Common") as! CommonViewController
        navigationController?.pushViewController(commonController, animated: true)
    }
    @IBAction func continueButton(_ sender: Any) {
        if(selectedTickType == nil || selectedTickType == tickOptions[0]) {return}
        
        let descriptionController = storyboard?.instantiateViewController(withIdentifier: "Description") as! DescriptionViewController
        descriptionController.uploadImage = preview.image
        descriptionController.tickType = selectedTickType
        navigationController?.pushViewController(descriptionController, animated: true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return tickOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let attributedString = NSAttributedString(string: tickOptions[row], attributes: [NSAttributedStringKey.foregroundColor : UIColor.white])
        return attributedString
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedTickType = tickOptions[row]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let contextSize: CGSize = uploadImage!.size
        let rect: CGRect = CGRect(origin: CGPoint(x: (contextSize.height - contextSize.width) / 2, y: 0), size: CGSize(width: contextSize.width, height: contextSize.width))
        let imageRef: CGImage = uploadImage!.cgImage!.cropping(to: rect)!
        preview.image = UIImage(cgImage: imageRef, scale: uploadImage!.scale, orientation: uploadImage!.imageOrientation)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
