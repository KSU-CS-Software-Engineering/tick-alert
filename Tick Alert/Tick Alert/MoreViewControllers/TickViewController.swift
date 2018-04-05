//
//  TickViewController.swift
//  Tick Alert
//
//  Created by David Freeman on 3/1/18.
//  Copyright © 2018 David Freeman. All rights reserved.
//

import UIKit

class TickViewController: UIViewController {

    @IBOutlet var tickImage: UIImageView!
    @IBOutlet var scienceName: UILabel!
    @IBOutlet var body: UITextView!
    @IBOutlet var roundedView: UIView!
    
    var id: Int?
    
    @IBAction func showDistributionMap(_ sender: Any) {
        let distributionController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DistributionMap") as! DistributionMapViewController
        distributionController.id = id
        self.addChildViewController(distributionController)
        distributionController.view.frame = self.view.frame
        distributionController.view.center = view.convert(view.center, from: view.superview)
        self.view.addSubview(distributionController.view)
        distributionController.didMove(toParentViewController: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roundedView.layer.cornerRadius = 8
        tickImage.layer.cornerRadius = 8
        body.layer.cornerRadius = 8
        tickImage.layer.masksToBounds = true
        body.layer.masksToBounds = false
        
        roundedView.layer.shadowColor = UIColor.black.cgColor
        roundedView.layer.shadowOpacity = 0.3
        roundedView.layer.shadowOffset = CGSize(width: 3, height: 3)
        roundedView.layer.shadowRadius = 2
        
        body.layer.shadowColor = UIColor.black.cgColor
        body.layer.shadowOpacity = 0.3
        body.layer.shadowOffset = CGSize(width: 3, height: 3)
        body.layer.shadowRadius = 2
        
        switch(id!) {
            case 0:
                tickImage.image = #imageLiteral(resourceName: "Ixodes_scapularis_all.jpg")
                self.title = "Blacklegged Tick"
                scienceName.text = "Ixodes scapularis "
                body.text = "Blacklegged ticks (a.k.a Deer ticks) take 2 years to complete their life cycle and are found predominately in deciduous forest. Their distribution relies greatly on the distribution of its reproductive host, white-tailed deer. Both nymph and adult stages transmit diseases such as Lyme disease, Babesiosis, and Anaplasmosis."
                break
            case 1:
                tickImage.image = #imageLiteral(resourceName: "Dermacentor_variabilis_all.jpg")
                self.title = "American Dog Tick"
                scienceName.text = "Dermacentor variabilis "
                body.text = "American Dog ticks are found predominantly in areas with little or no tree cover, such as grassy fields and scrubland, as well as along walkways and trails. They feed on a variety of hosts, ranging in size from mice to deer, and nymphs and adults can transmit diseases such as Rocky Mountain Spotted Fever and Tularemia. American dog ticks can survive for up to 2 years at any given stage if no host is found. Females can be identified by their large off-white scutum against a dark brown body."
                break
            case 2:
                tickImage.image = #imageLiteral(resourceName: "Amblyomma_americanum_all.jpg")
                self.title = "Lone Star Tick"
                scienceName.text = "Amblyomma americanum "
                body.text = "Lone Star ticks are found mostly in woodlands with dense undergrowth and around animal resting areas. The larvae do not carry disease, but the nymphal and adult stages can transmit the pathogens causing Monocytic Ehrlichiosis, Rocky Mountain Spotted Fever and 'Stari' borreliosis. Lone Star ticks are notorious pests, and all stages are aggressive human biters."
                break
            case 3:
                tickImage.image = #imageLiteral(resourceName: "Rhipicephalus_sanguineus_all.jpg")
                self.title = "Brown Dog Tick"
                scienceName.text = "Rhipicephalus sanguineus "
                body.text = "Brown Dog Ticks have a world-wide distribution, and can be found throughout the United States, although they are encountered more frequently in the southern tier of states. All life stages of this tick can transmit Rocky Mountain Spotted Fever rickettsia (Rickettsia rickettsia) to dogs, and rarely to humans. Both nymphal and adult stages can transmit the agents of canine ehrlichiosis (Ehrlichia canis) and canine babesiosis (Babesia canis vogeli and Babesia gibsoni-like) to dogs."
                break
            case 4:
                tickImage.image = #imageLiteral(resourceName: "Dermacentor_andersoni_all.jpg")
                self.title = "Rocky Mountain Wood Tick"
                scienceName.text = "Dermacentor andersoni "
                body.text = "Rocky Mountain Wood ticks are found predominantly in shrublands, lightly wooded areas, open grasslands, and along trails, mainly at lower elevations. All life stages of this tick can transmit Colorado tick fever virus (CTFV) to humans, and Rocky Mountain spotted fever (RMSF) rickettsia (Rickettsia rickettsii) to humans, cats, and dogs. Rocky Mountain wood tick saliva contains a neurotoxin that can occasionally cause tick paralysis in humans and pets; usually a bite from an adult female induces an ascending paralysis that dissipates within 24-72 hrs after tick removal."
                break
            default:
                break
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        body.setContentOffset(CGPoint.zero, animated: false)
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
