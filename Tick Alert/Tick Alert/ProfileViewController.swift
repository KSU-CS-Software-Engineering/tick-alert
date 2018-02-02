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
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var userBio: UILabel!
    
    var userId: Int!
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Log user into Google
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signInSilently()
        
        if(Auth.auth().currentUser != nil) {
            // Get the infomration of the user currently logged in
            let user = Auth.auth().currentUser
            let userId = user?.uid
            
            // Set name to Google display name
            self.userFirstAndLast.text = user?.displayName
            
            // Set the profile picture to Google profile picture
            let data = try? Data(contentsOf: (user?.photoURL)!)
            userProfileImage.image = UIImage(data: data!)
            
            // Get user location from databse
            ref = Database.database().reference()
            ref.child("user").child(userId!).observeSingleEvent(of: .value, with: { (snapshot) in
                // Get user value
                let value = snapshot.value as? NSDictionary
                
                // Set the location to value in database
                self.userLocation.text = value?.value(forKey: "location") as? String
                self.userBio.text = value?.value(forKey: "bio") as! String
            }) { (error) in
                print(error.localizedDescription)
            }
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
