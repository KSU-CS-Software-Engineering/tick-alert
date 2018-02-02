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

class ProfileViewController: UIViewController, GIDSignInUIDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! CollectionViewCell
        if(Auth.auth().currentUser != nil) {
            let user = Auth.auth().currentUser
            let userId = user?.uid
            ref = Database.database().reference()
            ref.child("user").child(userId!).child("posts").observeSingleEvent(of: .value, with: { (snapshot) in
                let value = snapshot.value as? NSDictionary
                let postIds = value?.allKeys
                self.ref.child("post").child(postIds![indexPath.row] as! String).observeSingleEvent(of: .value, with: { (snapshot) in
                    let value = snapshot.value as? NSDictionary
                    let urlString = value?.value(forKey: "imageUrl") as? String
                    let url = URL(string: urlString!)
                    let data = try? Data(contentsOf: url!)
                    cell.displayContent(image: UIImage(data: data!)!)
                }) { (error) in
                    print(error.localizedDescription)
                }
            }) { (error) in
                print(error.localizedDescription)
            }
        }
        return cell
    }
    
    
    @IBOutlet weak var userLocation: UILabel!
    @IBOutlet weak var userFirstAndLast: UILabel!
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var userBio: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    
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
                self.userBio.text = value?.value(forKey: "bio") as? String
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
