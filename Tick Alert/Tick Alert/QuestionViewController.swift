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
    
    var question: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        
        switch(question!) {
            case 0:
                self.title = "Tick Removal"
                image.image = #imageLiteral(resourceName: "removal-ab.jpg")
                bigLabel.text = "How to Remove a Tick"
                body.text = "1. Use fine-tipped tweezers to grasp the tick as close to the skin's surface as possible.\n\n2. Pull upward with steady, even pressure. Don't twist or jerk the tick; this can cause the mouth-parts to break off and remain in the skin. If this happens, remove the mouth-parts with tweezers. If you are unable to remove the mouth easily with clean tweezers, leave it alone and let the skin heal.\n\n3. After removing the tick, thoroughly clean the bite area and your hands with rubbing alcohol, an iodine scrub, or soap and water.\n\n4. Dispose of a live tick by submersing it in alcohol, placing it in a sealed bag/container, wrapping it tightly in tape, or flushing it down the toilet. Never crush a tick with your fingers."
                break
            case 1:
                self.title = "Tick Identification"
                image.image = #imageLiteral(resourceName: "removal-ab.jpg")
                bigLabel.text = "How to Remove a Tick"
                body.text = "1. Use fine-tipped tweezers to grasp the tick as close to the skin's surface as possible.\n\n2. Pull upward with steady, even pressure. Don't twist or jerk the tick; this can cause the mouth-parts to break off and remain in the skin. If this happens, remove the mouth-parts with tweezers. If you are unable to remove the mouth easily with clean tweezers, leave it alone and let the skin heal.\n\n3. After removing the tick, thoroughly clean the bite area and your hands with rubbing alcohol, an iodine scrub, or soap and water.\n\n4. Dispose of a live tick by submersing it in alcohol, placing it in a sealed bag/container, wrapping it tightly in tape, or flushing it down the toilet. Never crush a tick with your fingers."
                break
            case 2:
                self.title = "Avoiding Ticks"
                image.image = #imageLiteral(resourceName: "removal-ab.jpg")
                bigLabel.text = "How to Remove a Tick"
                body.text = "1. Use fine-tipped tweezers to grasp the tick as close to the skin's surface as possible.\n\n2. Pull upward with steady, even pressure. Don't twist or jerk the tick; this can cause the mouth-parts to break off and remain in the skin. If this happens, remove the mouth-parts with tweezers. If you are unable to remove the mouth easily with clean tweezers, leave it alone and let the skin heal.\n\n3. After removing the tick, thoroughly clean the bite area and your hands with rubbing alcohol, an iodine scrub, or soap and water.\n\n4. Dispose of a live tick by submersing it in alcohol, placing it in a sealed bag/container, wrapping it tightly in tape, or flushing it down the toilet. Never crush a tick with your fingers."
                break
            case 3:
                self.title = "Tick-Borne Diseases"
                image.image = #imageLiteral(resourceName: "removal-ab.jpg")
                bigLabel.text = "How to Remove a Tick"
                body.text = "1. Use fine-tipped tweezers to grasp the tick as close to the skin's surface as possible.\n\n2. Pull upward with steady, even pressure. Don't twist or jerk the tick; this can cause the mouth-parts to break off and remain in the skin. If this happens, remove the mouth-parts with tweezers. If you are unable to remove the mouth easily with clean tweezers, leave it alone and let the skin heal.\n\n3. After removing the tick, thoroughly clean the bite area and your hands with rubbing alcohol, an iodine scrub, or soap and water.\n\n4. Dispose of a live tick by submersing it in alcohol, placing it in a sealed bag/container, wrapping it tightly in tape, or flushing it down the toilet. Never crush a tick with your fingers."
                break
            case 4:
                self.title = "Tick Distribution"
                image.image = #imageLiteral(resourceName: "removal-ab.jpg")
                bigLabel.text = "How to Remove a Tick"
                body.text = "1. Use fine-tipped tweezers to grasp the tick as close to the skin's surface as possible.\n\n2. Pull upward with steady, even pressure. Don't twist or jerk the tick; this can cause the mouth-parts to break off and remain in the skin. If this happens, remove the mouth-parts with tweezers. If you are unable to remove the mouth easily with clean tweezers, leave it alone and let the skin heal.\n\n3. After removing the tick, thoroughly clean the bite area and your hands with rubbing alcohol, an iodine scrub, or soap and water.\n\n4. Dispose of a live tick by submersing it in alcohol, placing it in a sealed bag/container, wrapping it tightly in tape, or flushing it down the toilet. Never crush a tick with your fingers."
                break
            case 5:
                self.title = "Preventing Tick Bites"
                image.image = #imageLiteral(resourceName: "removal-ab.jpg")
                bigLabel.text = "How to Remove a Tick"
                body.text = "1. Use fine-tipped tweezers to grasp the tick as close to the skin's surface as possible.\n\n2. Pull upward with steady, even pressure. Don't twist or jerk the tick; this can cause the mouth-parts to break off and remain in the skin. If this happens, remove the mouth-parts with tweezers. If you are unable to remove the mouth easily with clean tweezers, leave it alone and let the skin heal.\n\n3. After removing the tick, thoroughly clean the bite area and your hands with rubbing alcohol, an iodine scrub, or soap and water.\n\n4. Dispose of a live tick by submersing it in alcohol, placing it in a sealed bag/container, wrapping it tightly in tape, or flushing it down the toilet. Never crush a tick with your fingers."
                break
            default:
                break
        }
        
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
