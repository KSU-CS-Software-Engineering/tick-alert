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
    
    var tickType: String?
    var desc: String?
    var location: CLLocationCoordinate2D?
    var uploadImage: UIImage?
    var date: String?
    let months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]

    @IBAction func submitButton(_ sender: Any) {
        let ref = Database.database().reference()
        ref.child("post").observeSingleEvent(of: .value, with: {(snapshot) in
            let numberOfPosts = snapshot.childrenCount
            let storageRef = Storage.storage().reference()
            let picRef = storageRef.child("posts").child(String(numberOfPosts))
            picRef.putData(UIImagePNGRepresentation(self.uploadImage!)!, metadata: nil) {(metadata, error) in
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
                            "type": self.tickType!
                        ]
                        ref.child("post").child("\(numberOfPosts)").setValue(newPostData)
                        ref.child("user").child(Auth.auth().currentUser!.uid).child("posts").observeSingleEvent(of: .value, with: {(snapshot) in
                            let numberOfUserPosts = snapshot.childrenCount
                            ref.child("user").child(Auth.auth().currentUser!.uid).child("posts").updateChildValues(["\(numberOfUserPosts+1)": numberOfPosts])
                        })
                    } else {
                        print(error!.localizedDescription)
                    }
                })
            }
        })
        
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tickImage.image = uploadImage!
        tickTypeLabel.text = tickType!
        userLabel.text = Auth.auth().currentUser?.displayName
        descriptionLabel.text = desc!
        
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
