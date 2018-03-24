//
//  CommentsViewController.swift
//  Tick Alert
//
//  Created by David Freeman on 3/23/18.
//  Copyright © 2018 David Freeman. All rights reserved.
//

import UIKit
import Firebase

class CommentsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var commentsTable: UITableView!
    @IBOutlet var tickImage: UIImageView!
    @IBOutlet var tickSpecie: UILabel!
    @IBOutlet var tickSex: UILabel!
    @IBOutlet var date: UILabel!
    @IBOutlet var location: UILabel!
    @IBOutlet var user: UILabel!
    var postId = ""
    var image: UIImage = UIImage()
    var specie = ""
    var sex = ""
    var dt = ""
    var loc = ""
    var userName = ""
    var commentsCount = 0
    var comments: NSArray = []
    let ref = Database.database().reference()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = commentsTable.dequeueReusableCell(withIdentifier: "CommentsCell", for: indexPath) as! CommentsTableViewCell
        
        let comment = comments[indexPath.row] as! NSDictionary
        
        // Set User Profile Picture
        let picRef = Storage.storage().reference(withPath: "users/\(comment["poster"] as! String).jpg")
        picRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print(error.localizedDescription)
                cell.commenterImage.image = #imageLiteral(resourceName: "profile")
            } else {
                cell.commenterImage.image = UIImage(data: data!)
            }
        }
        
        cell.comment.text = comment["body"] as? String
        
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        
        ref.child("post").child("\(postId)").child("comments").observeSingleEvent(of: .value, with: { (snapshot) in
            self.commentsCount = Int(snapshot.childrenCount)
            if(self.commentsCount > 0) {
                self.comments = snapshot.value as! NSArray
            }
            self.commentsTable.reloadData()
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tickImage.image = image
        tickSpecie.text = specie
        tickSex.text = sex
        date.text = dt
        location.text = loc
        user.text = userName
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
