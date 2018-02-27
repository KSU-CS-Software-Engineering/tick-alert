//
//  QuestionViewController.swift
//  Tick Alert
//
//  Created by David Freeman on 2/27/18.
//  Copyright © 2018 David Freeman. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    
    @IBOutlet var body: UILabel!
    @IBOutlet var bigLabel: UILabel!
    @IBOutlet var image: UIImageView!
    
    var answerTitle: String?
    var header: UIImage?
    var answer: String?
    var question: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        self.title = question
        image.image = header
        body.text = answer
        bigLabel.text = answerTitle
        
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
