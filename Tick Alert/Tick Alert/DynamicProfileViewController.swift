//
//  DynamicProfileViewController.swift
//  Tick Alert
//
//  Created by Caullen Sasnett on 2/13/18.
//  Copyright © 2018 David Freeman. All rights reserved.
//

import UIKit
import Firebase

// Similar to the ProfileView, but has a navigation bar and can be populated by an user's data
class DynamicProfileViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    var profileId: String!
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userLocation: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var userBio: UILabel!
    
    var numberOfPosts = 0
    
    // Returns the number of times a new CollectionViewCell should be created
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfPosts
    }
    
    // Creates a new CollectionViewCell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! CollectionViewCell
        if(Auth.auth().currentUser == nil) {return cell}
        
        // Populates CollectionViewCell with the picture of the tick
        let ref = Database.database().reference()
        ref.child("user/"+profileId+"/posts").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSArray
            let post = value?[indexPath.row+1] as! Int
            ref.child("post").child("\(post)").observeSingleEvent(of: .value, with: { (snapshot) in
                let value = snapshot.value as? NSDictionary
                
                let imagePaths = UserDefaults.standard.dictionary(forKey: "images") as! [String:String]
                if let path = imagePaths["\(post)"] {
                    let fullPath = self.documentsPathForFileName(name: path)
                    let imageData = NSData(contentsOfFile: fullPath)
                    let pic = UIImage(data: imageData! as Data)
                    cell.displayContent(image: pic!)
                } else {
                    let urlString = value?.value(forKey: "imageUrl") as? String
                    let url = URL(string: urlString!)
                    let data = try? Data(contentsOf: url!)
                    cell.displayContent(image: UIImage(data: data!)!)
                }
                
                cell.postId = post
            }) { (error) in
                print(error.localizedDescription)
            }
        }) { (error) in
            print(error.localizedDescription)
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
    
    // Populates the View with information from the Firebase database of the given user
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        let ref = Database.database().reference()
        
        // Sets number of posts by the given user
        ref.child("user/"+profileId+"/posts").observeSingleEvent(of: .value, with: { (snapshot) in
            self.numberOfPosts = Int(snapshot.childrenCount)
            self.collectionView.reloadData()
        })
        
        // Sets the name, location, and bio of the given user
        ref.child("user").child(profileId).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            self.userName.text = value?.value(forKey: "name") as? String
            self.userLocation.text = value?.value(forKey: "location") as? String
            self.userBio.text = value?.value(forKey: "bio") as? String
            
            self.title = self.userName.text
        }) { (error) in
            print(error.localizedDescription)
        }
        
        // Set User Profile Picture
        let picRef = Storage.storage().reference(withPath: "users/"+profileId+".jpg")
        picRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                let image = UIImage(data: data!)
                self.profileImage.image = image
            }
        }
        self.profileImage.layer.borderWidth = 1
        self.profileImage.layer.masksToBounds = false
        self.profileImage.layer.borderColor = UIColor.black.cgColor
        self.profileImage.layer.cornerRadius = self.profileImage.frame.height/2
        self.profileImage.clipsToBounds = true
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: screenWidth/3, height: screenWidth/3)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView!.collectionViewLayout = layout
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func documentsPathForFileName(name: String) -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let path = paths[0] as NSString
        let fullPath = path.appendingPathComponent(name)
        return fullPath
    }
}

