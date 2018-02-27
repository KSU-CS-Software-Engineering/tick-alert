//
//  FAQViewController.swift
//  Tick Alert
//
//  Created by David Freeman on 2/27/18.
//  Copyright © 2018 David Freeman. All rights reserved.
//

import UIKit

class FAQViewController: UITableViewController {

    //Topics in the FAQ
    let cellContent = ["Tick Removal", "Tick Identification", "Avoiding Ticks", "Tick-Borne Diseases", "Tick Distribution", "Preventing Tick Bites"]
    
    //return number of cells
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    //Dynamically create cells
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
        
        cell.textLabel?.text = cellContent[indexPath.row]
        
        return cell
    }
    
    //Handle navigation upon selection of row
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let questionController = storyboard?.instantiateViewController(withIdentifier: "Question") as! QuestionViewController //instantiate question controller
        
        switch(indexPath.row) {
            case 0:
                questionController.header = #imageLiteral(resourceName: "removal-ab.jpg")
                questionController.answerTitle = "How to remove a tick"
                questionController.answer = "1. Use fine-tipped tweezers to grasp the tick as close to the skin's surface as possible.\n\n2. Pull upward with steady, even pressure. Don't twist or jerk the tick; this can cause the mouth-parts to break off and remain in the skin. If this happens, remove the mouth-parts with tweezers. If you are unable to remove the mouth easily with clean tweezers, leave it alone and let the skin heal.\n\n3. After removing the tick, thoroughly clean the bite area and your hands with rubbing alcohol, an iodine scrub, or soap and water.\n\n4. Dispose of a live tick by submersing it in alcohol, placing it in a sealed bag/container, wrapping it tightly in tape, or flushing it down the toilet. Never crush a tick with your fingers."
                break
            case 1:
                questionController.header = #imageLiteral(resourceName: "Tick")
                questionController.answerTitle = "Tick Identification"
                break
            case 2:
                questionController.header = #imageLiteral(resourceName: "Tick")
                questionController.answerTitle = "Avoiding Ticks"
                break
            case 3:
                questionController.header = #imageLiteral(resourceName: "Tick")
                questionController.answerTitle = "Tick-Borne Diseases"
                break
            case 4:
                questionController.header = #imageLiteral(resourceName: "Tick")
                questionController.answerTitle = "Tick Districution"
                break
            case 5:
                questionController.header = #imageLiteral(resourceName: "Tick")
                questionController.answerTitle = "Preventing Tick Bites"
                break
            default:
                break
        }
        
        questionController.question = cellContent[indexPath.row]
        navigationController?.pushViewController(questionController, animated: true) //navigate to Question view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
