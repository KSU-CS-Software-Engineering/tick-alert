//
//  PreviewViewController.swift
//  Tick Alert
//
//  Created by David Freeman on 3/1/18.
//  Copyright © 2018 David Freeman. All rights reserved.
//

import UIKit
import MapKit
import Firebase

class PreviewViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    @IBOutlet var tickImage: UIImageView!
    @IBOutlet var tickTypeLabel: UILabel!
    @IBOutlet var userLabel: UILabel!
    @IBOutlet var map: MKMapView!
    @IBOutlet var elevationLabel: UILabel!
    @IBOutlet var weatherImage: UIImageView!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var sexLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var descriptionLabel: UITextView!
    @IBOutlet var roundedView: UIView!
    
    var buttonPressed = false
    var locationText = ""
    var tickType: String?
    var desc: String?
    var location: CLLocationCoordinate2D?
    var uploadImage: UIImage?
    var date: String?
    var sex: String?
    var ornation: String?
    var capitulum: String?
    var whereFound: String?
    var temperature = ""
    var elevation = ""
    var weatherURL = ""
    let months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    
    @objc func nextButtonPressed() {
        if(buttonPressed) {return}
        buttonPressed = true
        let ref = Database.database().reference()
        ref.child("post").observeSingleEvent(of: .value, with: {(snapshot) in
            let numberOfPosts = snapshot.childrenCount
            let storageRef = Storage.storage().reference()
            let picRef = storageRef.child("posts").child(String(numberOfPosts))
            let lowResImage = UIImageJPEGRepresentation(self.uploadImage!, 0)
            picRef.putData(lowResImage!, metadata: nil) {(metadata, error) in
                guard metadata != nil else {
                    print(error!.localizedDescription)
                    return
                }
                picRef.downloadURL(completion: {(url, error) in
                    if(url != nil) {
                        let newPostData = [
                            "date": self.date!,
                            "description": self.desc!,
                            "imageUrl": String(describing: url!),
                            "lat": self.location!.latitude,
                            "lon": self.location!.longitude,
                            "location": self.locationText as Any,
                            "poster": Auth.auth().currentUser!.uid,
                            "posterName": self.userLabel.text as Any,
                            "type": self.tickType!,
                            "sex": self.sex!,
                            "where": self.whereFound!,
                            "weatherURL": self.weatherURL,
                            "temperature": self.temperature,
                            "elevation": self.elevation
                        ]
                        ref.child("post").child("\(numberOfPosts)").setValue(newPostData)
                        ref.child("user").child(Auth.auth().currentUser!.uid).child("posts").observeSingleEvent(of: .value, with: {(snapshot) in
                            let numberOfUserPosts = snapshot.childrenCount
                            ref.child("user").child(Auth.auth().currentUser!.uid).child("posts").updateChildValues(["\(numberOfUserPosts+1)": numberOfPosts])
                            
                            self.navigationController?.popToRootViewController(animated: true)
                        })
                    } else {
                        print(error!.localizedDescription)
                    }
                })
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tickImage.image = uploadImage!
        tickTypeLabel.text = tickType!
        userLabel.text = Auth.auth().currentUser?.displayName
        descriptionLabel.text = desc!
        buttonPressed = false
        map.mapType = .hybrid
        
        //Create and place pin on map
        let currentDate = Date()
        let calendar = Calendar.current
        let day = calendar.component(.day, from: currentDate)
        let month = calendar.component(.month, from: currentDate)
        let year = calendar.component(.year, from: currentDate)
        let pin = MKPointAnnotation()
        pin.title = tickType!
        pin.subtitle = String(day) + " " + months[month-1] + " " + String(year)
        date = pin.subtitle
        pin.coordinate = location!
        map.addAnnotation(pin)
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location!, CLLocationDistance(1000), CLLocationDistance(1000))
        map.setRegion(coordinateRegion, animated: true)
        
        //get city and state information from coordinates
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(CLLocation(latitude: location!.latitude, longitude: location!.longitude), completionHandler: {(placemarks, error) in
            if(error == nil) {
                let city = placemarks?[0].locality
                let state = placemarks?[0].administrativeArea
                self.locationText = city! + ", " + state!
                
                //weather key: 92775877df4abb0e
                let semaphore = DispatchSemaphore(value: 0)
                let url = URL(string: "https://api.wunderground.com/api/92775877df4abb0e/conditions/q/\(state!)/\(city!.replacingOccurrences(of: " ", with: "_")).json")
                var request = URLRequest(url: url!)
                request.httpMethod = "POST"
                let task = URLSession.shared.dataTask(with: request) { data, response, error in
                    guard let data = data, error == nil else {
                        print(error?.localizedDescription ?? "No data")
                        return
                    }
                    let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                    if let responseJSON = responseJSON as? [String: Any] {
                        self.elevation = ((responseJSON["current_observation"] as! NSDictionary)["display_location"] as! NSDictionary)["elevation"] as! String
                        self.weatherURL = ((responseJSON["current_observation"] as! NSDictionary)["icon_url"] as! String).replacingOccurrences(of: "http", with: "https")
                        self.temperature = ((responseJSON["current_observation"] as! NSDictionary)["temperature_string"] as! String)
                        semaphore.signal()
                    }
                }
                task.resume()
                _ = semaphore.wait(timeout: DispatchTime.distantFuture)
                self.updateLabelsAndIcon()
            }
        })
        
        let nextButton = UIBarButtonItem(title: "Submit", style: UIBarButtonItemStyle.plain, target: self, action: #selector(nextButtonPressed))
        self.navigationItem.rightBarButtonItem = nextButton
        
        sexLabel.text = sex
        dateLabel.text = date
        
        map.layer.cornerRadius = 8
        roundedView.layer.cornerRadius = 8
        tickImage.layer.cornerRadius = 8
        tickImage.layer.masksToBounds = true
        
        roundedView.layer.shadowColor = UIColor.black.cgColor
        roundedView.layer.shadowOpacity = 0.3
        roundedView.layer.shadowOffset = CGSize(width: 3, height: 3)
        roundedView.layer.shadowRadius = 2
    }
    
    func updateLabelsAndIcon() {
        self.elevationLabel.text = self.elevation + " ft"
        self.temperatureLabel.text = self.temperature
        
        let url = URL(string: weatherURL)
        let data = try? Data(contentsOf: url!)
        if(data != nil) {weatherImage.image = UIImage(data: data!)}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
