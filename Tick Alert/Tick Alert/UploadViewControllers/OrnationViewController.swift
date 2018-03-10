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
    
    @IBOutlet var tickImage: UIImageView!
    @IBOutlet var ornationLabel: UILabel!
    @IBOutlet var exampleImage: UIImageView!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var ornationSelector: UISegmentedControl!
    
    @IBAction func ornationSelected(_ sender: Any) {
        switch(ornationSelector.selectedSegmentIndex) {
            case 0:
                ornationLabel.text = "ORNATE"
                exampleImage.image = #imageLiteral(resourceName: "ornate_ticks.png")
                descriptionLabel.text = "Ornate: colored markings present"
                break
            case 1:
                ornationLabel.text = "INORNATE"
                exampleImage.image = #imageLiteral(resourceName: "inornate_ticks.png")
                descriptionLabel.text = "Inornate: no colored markings present"
                break
            default:
                break
        }
    }
    
    @objc func nextButtonPressed() {
        let capitulumController = storyboard?.instantiateViewController(withIdentifier: "capitulum") as! CapitulumViewController
        capitulumController.uploadImage = uploadImage
        capitulumController.sex = sex
        if(ornationSelector.selectedSegmentIndex == 0) {capitulumController.ornation = "ORNATE"}
        else {capitulumController.ornation = "INORNATE"}
        navigationController?.pushViewController(capitulumController, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let nextButton = UIBarButtonItem(title: "Next", style: UIBarButtonItemStyle.plain, target: self, action: #selector(nextButtonPressed))
        self.navigationItem.rightBarButtonItem = nextButton
        
        ornationLabel.text = "ORNATE"
        exampleImage.image = #imageLiteral(resourceName: "ornate_ticks.png")
        descriptionLabel.text = "Ornate: colored markings present"
        
        tickImage.image = uploadImage
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
