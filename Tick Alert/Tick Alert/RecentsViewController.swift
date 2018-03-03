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
    
    var posts = [NSDictionary]()
    var images = [UIImage]()
    var totalNumberOfPosts = 0
    var numberOfPosts = 0
    
    //Return the number of recent posts - up to 25
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfPosts
    }
    
    //Dynamically create each cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "recentCell", for: indexPath) as! RecentCellViewController
        let post = numberOfPosts - indexPath.row - 1
        let value = posts[post]
                
        cell.recentTick.text = value.value(forKey: "type") as? String
        cell.recentDate.text = value.value(forKey: "date") as? String
        cell.recentLocation.text = value.value(forKey: "location") as? String
        cell.postId = UInt(post)
        if(images.count > indexPath.row) {cell.recentTickImage.image = images[post]}
        
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
        
        let ref = Database.database().reference()
        //Get posts and images from database and storage
        ref.child("post").observeSingleEvent(of: .value, with: { (snapshot) in
            self.totalNumberOfPosts = Int(snapshot.childrenCount)
            if(self.totalNumberOfPosts <= 25) {self.numberOfPosts = self.totalNumberOfPosts}
            else {self.numberOfPosts = 25}
            self.posts = snapshot.value as! [NSDictionary]
            
            for i in (self.totalNumberOfPosts-self.numberOfPosts...self.totalNumberOfPosts-1) {
                let value = self.posts[i]
                let urlString = value.value(forKey: "imageUrl") as? String
                let url = URL(string: urlString!)
                let data = try? Data(contentsOf: url!)
                if(data != nil) {self.images.append(UIImage(data: data!)!)}
                else {self.images.append(#imageLiteral(resourceName: "recenttick"))}
            }
            self.tableView.reloadData()
        })
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
