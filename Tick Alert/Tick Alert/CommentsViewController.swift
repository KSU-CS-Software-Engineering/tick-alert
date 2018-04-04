//
//  CommentsViewController.swift
//  Tick Alert
//
//  Created by David Freeman on 3/23/18.
//  Copyright © 2018 David Freeman. All rights reserved.
//

import UIKit
import Firebase

class CommentsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet var commentsTable: UITableView!
    @IBOutlet var tickImage: UIImageView!
    @IBOutlet var tickSpecie: UILabel!
    @IBOutlet var tickSex: UILabel!
    @IBOutlet var date: UILabel!
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
    var profilePics = [String:UIImage]()
    let ref = Database.database().reference()
    @IBOutlet var commentsInputContainerView: UIView!
    @IBOutlet var newCommentTextBox: UITextField!
    @IBOutlet var roundedView: UIView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = commentsTable.dequeueReusableCell(withIdentifier: "CommentsCell", for: indexPath) as! CommentsTableViewCell
        
        let comment = comments[indexPath.row] as! NSDictionary
        
        // Set User Profile Picture
        if let profilePic = profilePics["\(String(describing: comment["poster"]))"]{
            cell.commenterImage.image = profilePic
        } else {
            let picRef = Storage.storage().reference(withPath: "users/\(comment["poster"] as! String).jpg")
            picRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
                if let error = error {
                    print(error.localizedDescription)
                    cell.commenterImage.image = #imageLiteral(resourceName: "profile")
                } else {
                    let profilePic = UIImage(data: data!)!
                    self.profilePics["\(String(describing: comment["poster"]))"] = profilePic
                    cell.commenterImage.image = profilePic
                }
            }
        }
        
        cell.comment.text = comment["body"] as? String
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        self.view.endEditing(true)
        tableView.deselectRow(at: indexPath, animated: true)
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
    
    var bottomConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roundedView.layer.cornerRadius = 8
        tickImage.layer.cornerRadius = 8
        
        tickImage.image = image
        tickSpecie.text = specie
        tickSex.text = sex
        date.text = dt
        user.text = userName
        newCommentTextBox.delegate = self
        
        bottomConstraint = NSLayoutConstraint(item: commentsInputContainerView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottomMargin, multiplier: 1, constant: 0)
        view.addConstraint(bottomConstraint!)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func handleKeyboardNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let keyboardFrame = userInfo[UIKeyboardFrameEndUserInfoKey] as! CGRect
            
            if(notification.name == NSNotification.Name.UIKeyboardWillShow) {
                let window = UIApplication.shared.keyWindow
                let bottomPadding = window?.safeAreaInsets.bottom
                bottomConstraint?.constant = -keyboardFrame.height + bottomPadding!
            } else {
                bottomConstraint?.constant = 0
            }
            
            UIView.animate(withDuration: 0, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                self.view.layoutIfNeeded()
                }, completion: { (completed) in
                    
            })
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        let newCommentData = [
            "body": newCommentTextBox.text!,
            "poster": Auth.auth().currentUser!.uid
            ] as [String : Any]
        ref.child("post").child(postId).child("comments").child("\(commentsCount)").setValue(newCommentData)
        
        ref.child("post").child("\(postId)").child("comments").observeSingleEvent(of: .value, with: { (snapshot) in
            self.commentsCount = Int(snapshot.childrenCount)
            if(self.commentsCount > 0) {
                self.comments = snapshot.value as! NSArray
            }
            self.commentsTable.reloadData()
        })
        
        newCommentTextBox.text = ""
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
