//
//  RecentsViewController.swift
//  Tick Alert
//
//  Created by David Freeman on 10/8/17.
//  Copyright © 2017 David Freeman. All rights reserved.
//

import UIKit

class RecentsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let cellContent = ["Deer Tick - Manhattan,KS", "American Dog Tick - Kansas City, MO", "Pigeon Tick - New York, NY", "Ornate Cow Tick - Bartlesville, OK", "Deer Tick - Leavenworth, KS", "Ixodes Ricinus - Lincoln, NE", "Nuttalliella - Salem, OR", "Ornate Cow Tick - Orlando, FL", "Pigeon Tick - Long Beach, CA", "American Dog Tick - Springfield, MO"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellContent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
        
        cell.textLabel?.text = cellContent[indexPath.row]
        
        return cell
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
