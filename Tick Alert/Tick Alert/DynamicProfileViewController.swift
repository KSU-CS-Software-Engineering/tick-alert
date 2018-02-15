//
//  DynamicProfileViewController.swift
//  Tick Alert
//
//  Created by Caullen Sasnett on 2/13/18.
//  Copyright © 2018 David Freeman. All rights reserved.
//

import UIKit
import Firebase

class DynamicProfileViewController: UIViewController {
    var profileId: String!
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userLocation: UILabel!
    @IBOutlet weak var userBio: UILabel!
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        let ref = Database.database().reference()
        ref.child("user").child(profileId).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            self.userName.text = value?.value(forKey: "name") as! String
            self.userLocation.text = value?.value(forKey: "location") as? String
            self.userBio.text = value?.value(forKey: "bio") as? String
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
