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
    var commentsCount = 0
    var comments: NSDictionary = [:]
    let ref = Database.database().reference()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = commentsTable.dequeueReusableCell(withIdentifier: "CommentsCell", for: indexPath) as! CommentsTableViewCell
        
        let comment = comments["\(indexPath.row)"] as! NSDictionary
        
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
            self.comments = snapshot.value as! NSDictionary
            self.commentsCount = Int(snapshot.childrenCount)
            self.commentsTable.reloadData()
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
