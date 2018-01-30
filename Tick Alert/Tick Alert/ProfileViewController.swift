//
//  ProfileViewController.swift
//  Tick Alert
//
//  Created by David Freeman on 10/8/17.
//  Copyright © 2017 David Freeman. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class ProfileViewController: UIViewController, GIDSignInUIDelegate {
    
    @IBOutlet weak var userLocation: UILabel!
    @IBOutlet weak var userFirstAndLast: UILabel!
    
    var ref: DatabaseReference!
    let userId = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signIn()
        
        // TODO(developer) Configure the sign-in button look/feel
        // ...

        ref = Database.database().reference()
        self.ref.child("user/\(userId)/username").setValue("greasyw00t")
        
        
        ref.child("user").child("\(userId)").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            print(value)
            self.userFirstAndLast.text = value?.value(forKey: "name") as! String
            self.userLocation.text = value?.value(forKey: "location") as! String
        }) { (error) in
            print(error.localizedDescription)
        }
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
