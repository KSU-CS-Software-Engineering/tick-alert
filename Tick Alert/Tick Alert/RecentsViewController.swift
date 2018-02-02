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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(recentPosts > 25) {return 25}
        return recentPosts
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "recentCell", for: indexPath) as! RecentCellViewController
        
        let ref = Database.database().reference()
        ref.child("post").observeSingleEvent(of: .value, with: { (snapshot) in
            let numberOfPosts = snapshot.childrenCount
        
            let post = numberOfPosts - UInt(indexPath.row) - 1
            ref.child("post").child("\(post)").observeSingleEvent(of: .value, with: { (snapshot) in
                
                let value = snapshot.value as? NSDictionary
                
                cell.recentTick.text = value?.value(forKey: "type") as? String
                cell.recentDate.text = value?.value(forKey: "date") as? String
                cell.recentLocation.text = value?.value(forKey: "location") as? String
                
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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
