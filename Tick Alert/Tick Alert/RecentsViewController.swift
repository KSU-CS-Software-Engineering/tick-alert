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
    
    var recentPosts = 0
    
    //Return the number of recent posts - up to 25
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(recentPosts > 25) {return 25}
        return recentPosts
    }
    
    //Dynamically create each cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "recentCell", for: indexPath) as! RecentCellViewController
        
        let ref = Database.database().reference()
        //Get number of posts from the Database
        ref.child("post").observeSingleEvent(of: .value, with: { (snapshot) in
            let numberOfPosts = snapshot.childrenCount
        
            let post = numberOfPosts - UInt(indexPath.row) - 1
            //Get post that matches cell row
            ref.child("post").child("\(post)").observeSingleEvent(of: .value, with: { (snapshot) in
                
                let value = snapshot.value as? NSDictionary
                
                cell.recentTick.text = value?.value(forKey: "type") as? String
                cell.recentDate.text = value?.value(forKey: "date") as? String
                cell.recentLocation.text = value?.value(forKey: "location") as? String
                
                cell.postId = post
                
                let urlString = value?.value(forKey: "imageUrl") as? String
                let url = URL(string: urlString!)
                let data = try? Data(contentsOf: url!)
                cell.recentTickImage.image = UIImage(data: data!)
            }) { (error) in
                print(error.localizedDescription)
            }
        }) { (error) in
            print(error.localizedDescription)
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
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Get the number of posts from the database and reload table
        let ref = Database.database().reference()
        ref.child("post").observeSingleEvent(of: .value, with: { (snapshot) in
            self.recentPosts = Int(snapshot.childrenCount)
            self.tableView.reloadData()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
