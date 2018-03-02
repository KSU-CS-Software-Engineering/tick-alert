//
//  DescriptionViewController.swift
//  Tick Alert
//
//  Created by David Freeman on 3/1/18.
//  Copyright © 2018 David Freeman. All rights reserved.
//

import UIKit

class DescriptionViewController: UIViewController {
    
    var tickType: String?
    var uploadImage: UIImage?

    @IBOutlet var textField: UITextView!
    @IBAction func continueButton(_ sender: Any) {
        let locationController = storyboard?.instantiateViewController(withIdentifier: "Location") as! LocationViewController
        locationController.tickType = tickType!
        locationController.uploadImage = uploadImage
        locationController.desc = textField.text
        navigationController?.pushViewController(locationController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
