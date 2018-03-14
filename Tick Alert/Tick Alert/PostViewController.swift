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
    @IBOutlet var sexLabel: UILabel!
    @IBOutlet var poster: UIButton!
    @IBOutlet var datePosted: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var tickDescription: UILabel!
    @IBOutlet var elevationLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var weatherImage: UIImageView!
    @IBOutlet var tickImage: UIImageView!
    var posterId = ""
    var previousController = ""
    
    // When the poster's name is pressed, load a DynamicProfileView
    @IBAction func posterButtonPressed(_ sender: Any) {
        if(previousController == "Profile") {_ = navigationController?.popViewController(animated: true)}
        else {
            let profileController = self.storyboard?.instantiateViewController(withIdentifier: "DynamicProfile") as! DynamicProfileViewController
            profileController.profileId = posterId
            self.navigationController?.pushViewController(profileController, animated: true)
        }
    }
    
    var postId = ""
    var comments = 0
    let ref = Database.database().reference()
    
    // Returns the number of rows that should be created
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments
    }
    
    // Creates a new row in the table
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath) as! CommentsCellViewController
        
        let ref = Database.database().reference()
        ref.child("post").child("\(postId)").child("comments").child("\(indexPath.row)").observeSingleEvent(of: .value, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            
            // Set User Profile Picture
            let picRef = Storage.storage().reference(withPath: "users/\(value!.value(forKey: "poster") as! String).jpg")
            picRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
                if let error = error {
                    print(error.localizedDescription)
                    cell.profileImage.image = #imageLiteral(resourceName: "profile")
                } else {
                    cell.profileImage.image = UIImage(data: data!)
                }
            }
            cell.commentBody.text = value?.value(forKey: "body") as? String
        }) { (error) in
            print(error.localizedDescription)
        }
        
        return cell
    }
    
    // Defines the size of each row of the table
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    // Before the view appears, gets the number of comments a post has
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        
        ref.child("post").child("\(postId)").child("comments").observeSingleEvent(of: .value, with: { (snapshot) in
            self.comments = Int(snapshot.childrenCount)
            self.tableView.reloadData()
        })
    }

    // Populate the View with Post information from the Firebase database
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref.child("post").child("\(postId)").observeSingleEvent(of: .value, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            
            // Sets general post information for the given post
            self.tickType.text = value?.value(forKey: "type") as? String
            self.title = self.tickType.text
            self.datePosted.text = value?.value(forKey: "date") as? String
            self.tickDescription.text = value?.value(forKey: "description") as? String
            self.poster.setTitle(value?.value(forKey: "posterName") as? String, for: .normal)
            self.posterId = (value?.value(forKey: "poster") as? String)!
            self.sexLabel.text = value?.value(forKey: "sex") as? String
            self.locationLabel.text = value?.value(forKey: "location") as? String
            self.temperatureLabel.text = value?.value(forKey: "temperature") as? String
            self.elevationLabel.text = "\(value?.value(forKey: "elevation") as! String) ft"
            
            let weatherURLString = value?.value(forKey: "weatherURL") as! String
            let weatherURL = URL(string: weatherURLString)
            let weatherData = try? Data(contentsOf: weatherURL!)
            if(weatherData != nil) {self.weatherImage.image = UIImage(data: weatherData!)}
            
            // Sets image associated with the post
            let urlString = value?.value(forKey: "imageUrl") as? String
            let imageURL = URL(string: urlString!)
            let imageData = try? Data(contentsOf: imageURL!)
            if(imageData != nil) {self.tickImage.image = UIImage(data: imageData!)}
            else {self.tickImage.image = #imageLiteral(resourceName: "recenttick")}
            
            // Creates required information to display a map view of the post
            let lat: CLLocationDegrees = value?.value(forKey: "lat") as! CLLocationDegrees
            let lon: CLLocationDegrees = value?.value(forKey: "lon") as! CLLocationDegrees
            let title = value?.value(forKey: "type") as? String
            let subTitle = value?.value(forKey: "date") as? String
            let pin: MKPointAnnotation = MKPointAnnotation()
            pin.coordinate = CLLocationCoordinate2DMake(lat, lon)
            pin.title = title
            pin.subtitle = subTitle
            self.mapView.addAnnotation(pin)
            
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(lat, lon), CLLocationDistance(1000), CLLocationDistance(1000))
            self.mapView.setRegion(coordinateRegion, animated: true)
        }) { (error) in
            print(error.localizedDescription)
        }
        
        // Sets all rows to this height
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 60
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
