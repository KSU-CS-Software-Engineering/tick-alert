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
    @IBOutlet weak var userLocation: UILabel!
    @IBOutlet weak var userFirstAndLast: UILabel!
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var userBio: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    
    var posts = [NSDictionary]()
    var imagePaths = [String:String]()
    var postIds = [Any]()
    var postImages = [UIImage]()
    var numberOfPosts = 0
    
    // Returns the number of times a new CollectionViewCell should be created
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfPosts
    }
    
    // Creates a new CollectionViewCell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! CollectionViewCell
        if(Auth.auth().currentUser == nil) {return cell}
        
        cell.postId = postIds[indexPath.row+1] as! Int
        
        if let path = imagePaths["\(cell.postId)"] {
            let fullPath = documentsPathForFileName(name: path)
            let imageData = NSData(contentsOfFile: fullPath)
            let pic = UIImage(data: imageData! as Data)
            cell.tickImage.image = pic
        }
        else {
            let value = posts[cell.postId]
            let urlString = value.value(forKey: "imageUrl") as? String
            let url = URL(string: urlString!)
            if let data = try? Data(contentsOf: url!) {
                let relativePath = "image_\(NSDate.timeIntervalSinceReferenceDate).jpg"
                let path = documentsPathForFileName(name: relativePath)
                do {try data.write(to: URL(fileURLWithPath: path), options: .atomic)}
                catch {print(error)}
                imagePaths["\(cell.postId)"] = relativePath
                cell.tickImage.image = UIImage(data: data)
                UserDefaults.standard.set(imagePaths, forKey: "images")
            }
        }
        
        return cell
    }
    
    // Goes to PostView if a Cell is clicked
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let postController = storyboard?.instantiateViewController(withIdentifier: "Post") as! PostViewController
        let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
        postController.postId = "\(cell.postId!)"
        postController.previousController = "Profile"
        navigationController?.pushViewController(postController, animated: true)
    }
    
    // Populates the View with information from the Firebase database of the logged in user
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        // Log user into Google
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signIn()
        if(Auth.auth().currentUser == nil) {return}
        
        // Get the infomration of the user currently logged in
        let user = Auth.auth().currentUser
        let userId = user?.uid
        
        // Set name to Google display name
        self.userFirstAndLast.text = user?.displayName
        
        // Set the profile picture to Google profile picture
        let data = try? Data(contentsOf: (user?.photoURL)!)
        if(data != nil) {userProfileImage.image = UIImage(data: data!)}
        else {userProfileImage.image = #imageLiteral(resourceName: "profile")}
        
        // Get user and post information from database
        let ref = Database.database().reference()
        ref.child("user").child(userId!).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            
            // Set the location to value in database
            self.userLocation.text = value?.value(forKey: "location") as? String
            self.userBio.text = value?.value(forKey: "bio") as? String
            
            self.postIds = value?.value(forKey: "posts") as! [Any]
            self.numberOfPosts = self.postIds.count-1
    
            ref.child("post").observeSingleEvent(of: .value, with: {(snapshot) in
                self.posts = (snapshot.value as? [NSDictionary])!
                self.imagePaths = UserDefaults.standard.dictionary(forKey: "images") as! [String:String]
                self.collectionView.reloadData()
            }) {(error) in
                print("ERROR: \(error.localizedDescription)")
            }
        }) { (error) in
            print(error.localizedDescription)
        }
        
        // Upload profile picture to databse, if not done already
        let storageRef = Storage.storage().reference()
        let picRef =  storageRef.child("users").child(userId!+".jpg")
        _ = picRef.putData(data!, metadata: nil) { (metadata, error) in
            guard metadata != nil else {
                print(error!.localizedDescription)
                return
            }
        }
    }
    
    func documentsPathForFileName(name: String) -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let path = paths[0] as NSString
        let fullPath = path.appendingPathComponent(name)
        return fullPath
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
