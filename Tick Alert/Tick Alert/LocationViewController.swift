//
//  LocationViewController.swift
//  Tick Alert
//
//  Created by David Freeman on 3/1/18.
//  Copyright © 2018 David Freeman. All rights reserved.
//

import UIKit

class LocationViewController: UIViewController {

    @IBAction func continueButton(_ sender: Any) {
        let previewController = storyboard?.instantiateViewController(withIdentifier: "Preview") as! PreviewViewController
        navigationController?.pushViewController(previewController, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
