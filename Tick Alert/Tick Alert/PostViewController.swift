//
//  PostViewController.swift
//  Tick Alert
//
//  Created by David Freeman on 2/6/18.
//  Copyright © 2018 David Freeman. All rights reserved.
//

import UIKit
import MapKit
import Firebase

class PostViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var tickType: UILabel!
    @IBOutlet var poster: UIButton!
    @IBOutlet var datePosted: UILabel!
    @IBOutlet var tickDescription: UILabel!
    @IBOutlet var tickImage: UIImageView!
    var posterId = ""
    
    @IBAction func posterButtonPressed(_ sender: Any) {
        let profileController = self.storyboard?.instantiateViewController(withIdentifier: "DynamicProfile") as! DynamicProfileViewController
        profileController.profileId = posterId
        self.navigationController?.pushViewController(profileController, animated: true)
    }
    
    var postId = ""
    var comments = 0
    let ref = Database.database().reference()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath) as! CommentsCellViewController
        
        let ref = Database.database().reference()
        ref.child("post").child("\(postId)").child("comments").child("\(indexPath.row)").observeSingleEvent(of: .value, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            
            cell.commentBody.text = value?.value(forKey: "body") as? String
        }) { (error) in
            print(error.localizedDescription)
        }
        
        return cell
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        
        ref.child("post").child("\(postId)").child("comments").observeSingleEvent(of: .value, with: { (snapshot) in
            self.comments = Int(snapshot.childrenCount)
            self.tableView.reloadData()
        })
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref.child("post").child("\(postId)").observeSingleEvent(of: .value, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            
            self.tickType.text = value?.value(forKey: "type") as? String
            self.title = self.tickType.text
            self.datePosted.text = value?.value(forKey: "date") as? String
            self.tickDescription.text = value?.value(forKey: "description") as? String
            self.poster.setTitle(value?.value(forKey: "posterName") as? String, for: .normal)
            self.posterId = (value?.value(forKey: "poster") as? String)!
            
            let urlString = value?.value(forKey: "imageUrl") as? String
            let url = URL(string: urlString!)
            let data = try? Data(contentsOf: url!)
            self.tickImage.image = UIImage(data: data!)
            
            let lat = value?.value(forKey: "lat") as? Double
            let lon = value?.value(forKey: "lon") as? Double
            let title = value?.value(forKey: "type") as? String
            let subTitle = value?.value(forKey: "date") as? String
            let pin: MKPointAnnotation = MKPointAnnotation()
            pin.coordinate = CLLocationCoordinate2DMake(lat!, lon!)
            pin.title = title
            pin.subtitle = subTitle
            self.mapView.addAnnotation(pin)
            
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(lat!, lon!), CLLocationDistance(1000), CLLocationDistance(1000))
            self.mapView.setRegion(coordinateRegion, animated: true)
        }) { (error) in
            print(error.localizedDescription)
        }
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
