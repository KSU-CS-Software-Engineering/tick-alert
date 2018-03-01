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

class UploadViewController: UIViewController, UITextFieldDelegate {
    
    var uploadImage: UIImage?

    @IBOutlet var tickType: UITextField!
    @IBOutlet var preview: UIImageView!
    @IBAction func identificationTips(_ sender: Any) {
        let commonController = storyboard?.instantiateViewController(withIdentifier: "Common") as! CommonViewController
        navigationController?.pushViewController(commonController, animated: true)
    }
    @IBAction func continueButton(_ sender: Any) {
        let descriptionController = storyboard?.instantiateViewController(withIdentifier: "Description") as! DescriptionViewController
        navigationController?.pushViewController(descriptionController, animated: true)
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
