//
//  MoreViewController.swift
//  Tick Alert
//
//  Created by David Freeman on 10/8/17.
//  Copyright © 2017 David Freeman. All rights reserved.
//

import UIKit
import GoogleSignIn
import Firebase

class MoreViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, GIDSignInUIDelegate {
    
    //Options in the table
    let cellContent = ["FAQ", "Common Ticks", "About", "Settings", "Logout"]
    
    //Return number of rows in the table
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellContent.count
    }
    
    //Dynamically create each row of the table
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
        
        cell.textLabel?.text = cellContent[indexPath.row]
        
        return cell
    }
    
    //Handle navigation upon selection of row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        switch(indexPath.row) {
            case 0:
                let faqController = storyboard?.instantiateViewController(withIdentifier: "FAQ") as! FAQViewController //instantiate FAQ controller
                navigationController?.pushViewController(faqController, animated: true) //navigate to FAQ view
                break
            
            case 1:
                let commonController = storyboard?.instantiateViewController(withIdentifier: "Common") as! CommonViewController
                navigationController?.pushViewController(commonController, animated: true)
                break
        
            case 2:
                let aboutController = storyboard?.instantiateViewController(withIdentifier: "About") as! AboutViewController //instantiate About controller
                navigationController?.pushViewController(aboutController, animated: true) //navigate to About view
                break
            
            case 3:
                let settingsController = storyboard?.instantiateViewController(withIdentifier: "Settings") as! SettingsViewController //instantiate Settings controller
                navigationController?.pushViewController(settingsController, animated: true) //navigate to Settings view
                break
            
            case 4:
                GIDSignIn.sharedInstance().uiDelegate = self
                GIDSignIn.sharedInstance().signOut()
                do {try Auth.auth().signOut()} catch {}
                break
                
            default:
                print("cell")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
