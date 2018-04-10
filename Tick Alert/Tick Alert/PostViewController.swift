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

class PostViewController: UIViewController {
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var tickType: UILabel!
    @IBOutlet var sexLabel: UILabel!
    @IBOutlet var poster: UIButton!
    @IBOutlet var datePosted: UILabel!
    @IBOutlet var elevationLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var weatherImage: UIImageView!
    @IBOutlet var tickImage: UIImageView!
    var posterId = ""
    var previousController = ""
    var postId = ""
    let ref = Database.database().reference()
    var oldDescription = ""
    
    @IBOutlet var roundedView: UIView!
    @IBOutlet var tickDescription: UITextView!
    @IBAction func viewCommentsClicked(_ sender: Any) {
        let commentsController = self.storyboard?.instantiateViewController(withIdentifier: "Comments") as! CommentsViewController
        commentsController.image = tickImage.image!
        commentsController.specie = tickType.text!
        commentsController.sex = sexLabel.text!
        commentsController.dt = datePosted.text!
        commentsController.userName = (poster.titleLabel?.text)!
        commentsController.postId = postId
        self.navigationController?.pushViewController(commentsController, animated: true)
    }
    // When the poster's name is pressed, load a DynamicProfileView
    @IBAction func posterButtonPressed(_ sender: Any) {
        if(previousController == "Profile") {_ = navigationController?.popViewController(animated: true)}
        else {
            let profileController = self.storyboard?.instantiateViewController(withIdentifier: "DynamicProfile") as! DynamicProfileViewController
            profileController.profileId = posterId
            self.navigationController?.pushViewController(profileController, animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }

    // Populate the View with Post information from the Firebase database
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.mapType = .hybrid
        mapView.layer.cornerRadius = 8
        roundedView.layer.cornerRadius = 8
        tickImage.layer.cornerRadius = 8
        tickDescription.layer.cornerRadius = 8
        mapView.layer.masksToBounds = true
        tickImage.layer.masksToBounds = true
        
        roundedView.layer.shadowColor = UIColor.black.cgColor
        roundedView.layer.shadowOpacity = 0.3
        roundedView.layer.shadowOffset = CGSize(width: 3, height: 3)
        roundedView.layer.shadowRadius = 2
        
        mapView.layer.shadowColor = UIColor.black.cgColor
        mapView.layer.shadowOpacity = 0.3
        mapView.layer.shadowOffset = CGSize(width: 3, height: 3)
        mapView.layer.shadowRadius = 2
        
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
            self.temperatureLabel.text = value?.value(forKey: "temperature") as? String
            self.elevationLabel.text = "\(value?.value(forKey: "elevation") as! String) ft"
            
            let weatherURLString = value?.value(forKey: "weatherURL") as! String
            let weatherURL = URL(string: weatherURLString)
            let weatherData = try? Data(contentsOf: weatherURL!)
            if(weatherData != nil) {self.weatherImage.image = UIImage(data: weatherData!)}
            
            // Sets image associated with the post
            let imagePaths = UserDefaults.standard.dictionary(forKey: "images") as! [String:String]
            if let path = imagePaths["\(self.postId)"] {
                let fullPath = self.documentsPathForFileName(name: path)
                let imageData = NSData(contentsOfFile: fullPath)
                let pic = UIImage(data: imageData! as Data)
                self.tickImage.image = pic
            } else {
                let urlString = value?.value(forKey: "imageUrl") as? String
                let imageURL = URL(string: urlString!)
                let imageData = try? Data(contentsOf: imageURL!)
                if(imageData != nil) {self.tickImage.image = UIImage(data: imageData!)}
                else {self.tickImage.image = #imageLiteral(resourceName: "recenttick")}
            }
            
            // Creates required information to display a map view of the post
            let lat: CLLocationDegrees = value?.value(forKey: "lat") as! CLLocationDegrees
            let lon: CLLocationDegrees = value?.value(forKey: "lon") as! CLLocationDegrees
            let title = value?.value(forKey: "type") as? String
            let subTitle = value?.value(forKey: "location") as? String
            let pin: MKPointAnnotation = MKPointAnnotation()
            pin.coordinate = CLLocationCoordinate2DMake(lat, lon)
            pin.title = title
            pin.subtitle = subTitle
            self.mapView.addAnnotation(pin)
            
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(lat, lon), CLLocationDistance(1000), CLLocationDistance(1000))
            self.mapView.setRegion(coordinateRegion, animated: true)
            
            if(self.posterId == Auth.auth().currentUser?.uid) {
                let editButton = UIBarButtonItem(title: "Edit", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.editButtonPressed))
                self.navigationItem.rightBarButtonItem = editButton
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    @objc func editButtonPressed() {
        tickDescription.isEditable = true
        tickDescription.backgroundColor = UIColor.white
        oldDescription = tickDescription.text
        
        let saveButton = UIBarButtonItem(title: "Save", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.saveButtonPressed))
        self.navigationItem.rightBarButtonItem = saveButton
    }
    
    @objc func saveButtonPressed() {
        tickDescription.isEditable = false
        tickDescription.backgroundColor = UIColor.clear
        
        if(tickDescription.text != oldDescription) {
            ref.child("post").child(postId).child("description").setValue(tickDescription.text)
        }
        
        let editButton = UIBarButtonItem(title: "Edit", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.editButtonPressed))
        self.navigationItem.rightBarButtonItem = editButton
    }

    func documentsPathForFileName(name: String) -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let path = paths[0] as NSString
        let fullPath = path.appendingPathComponent(name)
        return fullPath
    }
}
