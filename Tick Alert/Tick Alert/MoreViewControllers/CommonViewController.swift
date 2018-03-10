//
//  CommonViewController.swift
//  Tick Alert
//
//  Created by David Freeman on 3/1/18.
//  Copyright © 2018 David Freeman. All rights reserved.
//

import UIKit

class CommonViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommonCell", for: indexPath) as! CommonCell
        switch(indexPath.row) {
            case 0:
                cell.tickType.text = "Blacklegged Tick"
                cell.tickPicture.image = #imageLiteral(resourceName: "Ixodes_scapularis_all.jpg")
                break
            case 1:
                cell.tickType.text = "American Dog Tick"
                cell.tickPicture.image = #imageLiteral(resourceName: "Dermacentor_variabilis_all.jpg")
                break
            case 2:
                cell.tickType.text = "Lone Star Tick"
                cell.tickPicture.image = #imageLiteral(resourceName: "Amblyomma_americanum_all.jpg")
                break
            case 3:
                cell.tickType.text = "Brown Dog Tick"
                cell.tickPicture.image = #imageLiteral(resourceName: "Rhipicephalus_sanguineus_all.jpg")
                break
            case 4:
                cell.tickType.text = "Rocky Mountain Wood Tick"
                cell.tickPicture.image = #imageLiteral(resourceName: "Dermacentor_andersoni_all.jpg")
                break
            default:
                break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tickController = storyboard?.instantiateViewController(withIdentifier: "tick") as! TickViewController
        tickController.id = indexPath.row
        navigationController?.pushViewController(tickController, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
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
