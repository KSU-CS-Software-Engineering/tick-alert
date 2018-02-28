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

 
    @IBOutlet var postButton: UIButton!
    @IBOutlet var tickDescription: UITextView!
    @IBOutlet var tickType: UITextField!
    @IBOutlet var map: MKMapView!
    @IBOutlet var preview: UIImageView!
    
    @IBAction func postButtonPressed(_ sender: Any) {
        if(tickType.text?.count == 0) {return}
        
        //TODO: upload post
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
        
        tickType.delegate = self
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
