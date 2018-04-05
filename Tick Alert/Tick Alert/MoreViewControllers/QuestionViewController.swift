//
//  QuestionViewController.swift
//  Tick Alert
//
//  Created by David Freeman on 2/27/18.
//  Copyright © 2018 David Freeman. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    
    @IBOutlet var body: UITextView!
    @IBOutlet var image: UIImageView!
    @IBOutlet var roundedView: UIView!
    
    var question: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        
        switch(question!) {
            case 0:
                self.title = "Tick Removal"
                image.image = #imageLiteral(resourceName: "removal-ab.jpg")
                body.text = "1. Use fine-tipped tweezers to grasp the tick as close to the skin's surface as possible.\n\n2. Pull upward with steady, even pressure. Don't twist or jerk the tick; this can cause the mouth-parts to break off and remain in the skin. If this happens, remove the mouth-parts with tweezers. If you are unable to remove the mouth easily with clean tweezers, leave it alone and let the skin heal.\n\n3. After removing the tick, thoroughly clean the bite area and your hands with rubbing alcohol, an iodine scrub, or soap and water.\n\n4. Dispose of a live tick by submersing it in alcohol, placing it in a sealed bag/container, wrapping it tightly in tape, or flushing it down the toilet. Never crush a tick with your fingers."
                break
            case 1:
                self.title = "Tick Identification"
                image.image = #imageLiteral(resourceName: "closeup.jpg")
                body.text = ""
                break
            case 2:
                self.title = "Avoiding Ticks"
                image.image = #imageLiteral(resourceName: "closeup.jpg")
                body.text = ""
                break
            case 3:
                self.title = "Tick-Borne Diseases"
                image.image = #imageLiteral(resourceName: "tickdisease.jpg")
                body.text = "In the United States, some ticks carry pathogens that can cause human disease, including:\n\n•Anaplasmosis is transmitted to humans by tick bites primarily from the blacklegged tick (Ixodes scapularis) in the northeastern and upper midwestern U.S. and the western blacklegged tick (Ixodes pacificus) along the Pacific coast.\n\n•Babesiosis is caused by microscopic parasites that infect red blood cells. Most human cases of babesiosis in the U.S. are caused by Babesia microti. Babesia microti is transmitted by the blacklegged tick (Ixodes scapularis) and is found primarily in the northeast and upper midwest.\n\n•Borrelia mayonii infection has recently been described as a cause of illness in the upper midwestern United States. It has been found in blacklegged ticks (Ixodes scapularis) in Minnesota and Wisconsin. Borrelia mayonii is a new species and is the only species besides B. burgdorferi known to cause Lyme disease in North America.\n\n•Borrelia miyamotoi infection has recently been described as a cause of illness in the U.S. It is transmitted by the blacklegged tick (Ixodes scapularis) and has a range similar to that of Lyme disease.\n\n•Bourbon virus infection has been identified in a limited number patients in the Midwest and southern United States. At this time, we do not know if the virus might be found in other areas of the United States.\n\n•Colorado tick fever is caused by a virus transmitted by the Rocky Mountain wood tick (Dermacentor andersoni). It occurs in the the Rocky Mountain states at elevations of 4,000 to 10,500 feet.\n\n•Ehrlichiosis is transmitted to humans by the lone star tick (Ambylomma americanum), found primarily in the southcentral and eastern U.S.\n\n•Heartland virus cases have been identified in the Midwestern and southern United States. Studies suggest that Lone Star ticks can transmit the virus. It is unknown if the virus may be found in other areas of the U.S.\n\n•Lyme disease is transmitted by the blacklegged tick (Ixodes scapularis) in the northeastern U.S. and upper midwestern U.S. and the western blacklegged tick (Ixodes pacificus) along the Pacific coast.\n\n•Powassan disease is transmitted by the blacklegged tick (Ixodes scapularis) and the groundhog tick (Ixodes cookei). Cases have been reported primarily from northeastern states and the Great Lakes region.\n\n•Rickettsia parkeri rickettsiosis is transmitted to humans by the Gulf Coast tick (Amblyomma maculatum).\n\n•Rocky Mountain spotted fever (RMSF) is transmitted by the American dog tick (Dermacentor variabilis), Rocky Mountain wood tick (Dermacentor andersoni), and the brown dog tick (Rhipicephalus sangunineus) in the U.S. The brown dog tick and other tick species are associated with RMSF in Central and South America.\n\n•STARI (Southern tick-associated rash illness) is transmitted via bites from the lone star tick (Ambylomma americanum), found in the southeastern and eastern U.S.\n\n•Tickborne relapsing fever (TBRF) is transmitted to humans through the bite of infected soft ticks. TBRF has been reported in 15 states: Arizona, California, Colorado, Idaho, Kansas, Montana, Nevada, New Mexico, Ohio, Oklahoma, Oregon, Texas, Utah, Washington, and Wyoming and is associated with sleeping in rustic cabins and vacation homes.\n\n•Tularemia is transmitted to humans by the dog tick (Dermacentor variabilis), the wood tick (Dermacentor andersoni), and the lone star tick (Amblyomma americanum). Tularemia occurs throughout the U.S.\n\n•364D rickettsiosis (Rickettsia phillipi, proposed) is transmitted to humans by the Pacific Coast tick (Dermacentor occidentalis ticks). This is a new disease that has been found in California."
                break
            case 5:
                self.title = "Preventing Tick Bites"
                image.image = #imageLiteral(resourceName: "tickbite.png")
                body.text = "Tick-borne diseases occur worldwide, including in your own backyard. To help protect yourself and your family, you should:\n\n•Use a chemical repellent with DEET, permethrin or picaridin.\n\n•Wear light-colored protective clothing.\n\n•Tuck pant legs into socks.\n\n•Avoid tick-infested areas.\n\n•Check yourself, your children, and your pets daily for ticks and carefully remove any ticks."
                break
            case 6:
                self.title = "Photo Optimization"
                image.image = #imageLiteral(resourceName: "closeup.jpg")
                body.text = ""
                break
            default:
                break
        }
        
        roundedView.layer.cornerRadius = 8
        roundedView.layer.masksToBounds = true
        image.layer.cornerRadius = 8
        image.layer.masksToBounds = true
        body.layer.cornerRadius = 8
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
