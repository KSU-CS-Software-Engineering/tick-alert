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
    
    @objc func nextButtonPressed() {
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let nextButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(nextButtonPressed))
        self.navigationItem.rightBarButtonItem = nextButton
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
