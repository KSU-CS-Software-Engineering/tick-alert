//
//  OrnationViewController.swift
//  Tick Alert
//
//  Created by David Freeman on 3/9/18.
//  Copyright © 2018 David Freeman. All rights reserved.
//

import UIKit

class OrnationViewController: UIViewController {
    
    var uploadImage: UIImage?
    var sex: String?
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
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