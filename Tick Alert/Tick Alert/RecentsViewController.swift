//
//  RecentsViewController.swift
//  Tick Alert
//
//  Created by David Freeman on 10/8/17.
//  Copyright © 2017 David Freeman. All rights reserved.
//

import UIKit
import Firebase

class RecentsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    var ref : DatabaseReference!
    
    var posts = [NSDictionary]()
    var imagePaths = [String:String]()
    var totalNumberOfPosts = 0
    var numberOfPostsToDisplay = 0
    
    //Return the number of recent posts - up to 25
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfPostsToDisplay
    }
    
    //Dynamically create each cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "recentCell", for: indexPath) as! RecentCellViewController
        let post = totalNumberOfPosts - indexPath.row - 1
        let value = posts[post]
                
        cell.recentTick.text = value.value(forKey: "type") as? String
        cell.recentDate.text = value.value(forKey: "date") as? String
        cell.recentLocation.text = value.value(forKey: "location") as? String
        cell.postId = UInt(post)
        if let path = imagePaths["\(post)"] {
            let fullPath = documentsPathForFileName(name: path)
            let imageData = NSData(contentsOfFile: fullPath)
            let pic = UIImage(data: imageData! as Data)
            cell.recentTickImage.image = pic
        }
        else {
            let urlString = value.value(forKey: "imageUrl") as? String
            let url = URL(string: urlString!)
            if let data = try? Data(contentsOf: url!) {
                let relativePath = "image_\(NSDate.timeIntervalSinceReferenceDate).jpg"
                let path = documentsPathForFileName(name: relativePath)
                do {try data.write(to: URL(fileURLWithPath: path), options: .atomic)}
                catch {print(error)}
                imagePaths["\(post)"] = relativePath
                cell.recentTickImage.image = UIImage(data: data)
                UserDefaults.standard.set(imagePaths, forKey: "images")
            }
        }
        
        return cell
    }
    
    //Handle navigation when post is selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let postController = storyboard?.instantiateViewController(withIdentifier: "Post") as! PostViewController //Instantiate post controller
        let cell = tableView.cellForRow(at: indexPath) as! RecentCellViewController //Get selected cell
        postController.postId = "\(cell.postId!)" //Use selected sell to pass postID to controller
        navigationController?.pushViewController(postController, animated: true) //Navigate to post view
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        
        ref = Database.database().reference()
        ref.child("post").observeSingleEvent(of: .value, with: { (snapshot) in
            self.totalNumberOfPosts = Int(snapshot.childrenCount)
            if(self.totalNumberOfPosts <= 25) {self.numberOfPostsToDisplay = self.totalNumberOfPosts}
            else {self.numberOfPostsToDisplay = 25}
            UserDefaults.standard.set(snapshot.value as! [NSDictionary], forKey: "posts")
            self.posts = snapshot.value as! [NSDictionary]
            self.imagePaths = UserDefaults.standard.dictionary(forKey: "images") as! [String:String]
            self.tableView.reloadData()
        })
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
