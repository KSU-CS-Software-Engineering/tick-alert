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
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var elevationLabel: UILabel!
    @IBOutlet var weatherImage: UIImageView!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var sexLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    var buttonPressed = false
    var tickType: String?
    var desc: String?
    var location: CLLocationCoordinate2D?
    var uploadImage: UIImage?
    var date: String?
    var sex: String?
    var ornation: String?
    var capitulum: String?
    var whereFound: String?
    var weather = ""
    var temperature = ""
    var elevation = ""
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
                            "location": self.locationLabel.text as Any,
                            "poster": Auth.auth().currentUser!.uid,
                            "posterName": self.userLabel.text as Any,
                            "type": self.tickType!,
                            "sex": self.sex!,
                            "where": self.whereFound!,
                            "weather": self.weather,
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
                self.locationLabel.text = (placemarks?[0].locality)! + ", " + (placemarks?[0].administrativeArea)!
            }
        })
        
        let nextButton = UIBarButtonItem(title: "Submit", style: UIBarButtonItemStyle.plain, target: self, action: #selector(nextButtonPressed))
        self.navigationItem.rightBarButtonItem = nextButton
        
        sexLabel.text = sex
        dateLabel.text = date
        
        //TODO: get elevation and weather info
        let url = URL(string: "https://maps.googleapis.com/maps/api/elevation/json?locations=\(location!.latitude),\(location!.longitude)&key=AIzaSyCrjKRm_68ZeAFFnTdQg55cJkHFUwQFk3g")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                self.elevation = "\(Double(round(1000*(((responseJSON["results"] as! NSArray)[0] as! NSDictionary)["elevation"] as! Double)))/1000)"
                self.updateElevationLabel()
            }
        }
        task.resume()
    }
    
    func updateElevationLabel() {
        self.elevationLabel.text = self.elevation + " ft"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
