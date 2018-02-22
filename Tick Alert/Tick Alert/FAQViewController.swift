//
//  FAQViewController.swift
//  Tick Alert
//
//  Created by David Freeman on 10/30/17.
//  Copyright © 2017 David Freeman. All rights reserved.
//

import UIKit

class FAQViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //Topics in the FAQ
    let cellContent = ["Tick Removal", "Tick Identification", "Avoiding Ticks", "Tick-Borne Diseases", "Tick Distribution", "Preventing Tick Bites"]
    
    //return number of cells
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    //Dynamically create cells
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

}
