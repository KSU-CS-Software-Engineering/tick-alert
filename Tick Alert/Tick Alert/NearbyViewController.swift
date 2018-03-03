//
//  NearbyViewController.swift
//  Tick Alert
//
//  Created by David Freeman on 10/8/17.
//  Copyright © 2017 David Freeman. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Firebase

class NearbyViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    @IBOutlet var map: MKMapView!
    var locationManager = CLLocationManager()
    
    var pinImages: [String:UIImage] = [:]
    var pinIDs: [String:UInt] = [:]
    
    //This function controls the 'center on current location' button
    @IBAction func centerOnLocationButtonPress(_ sender: Any) {
        locationManager.startUpdatingLocation() //Enables user tracking
        locationManager.stopUpdatingLocation() //Disables user tracking
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //parameters for map view
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.stopUpdatingLocation()
        
        //get post information from database
        let ref = Database.database().reference()
        ref.child("post").observeSingleEvent(of: .value, with: { (snapshot) in
            let numberOfPosts = snapshot.childrenCount
            
            for post in 0...numberOfPosts-1 {
                ref.child("post").child("\(post)").observeSingleEvent(of: .value, with: { (snapshot) in
                    
                    let value = snapshot.value as? NSDictionary
                    
                    let lat = value?.value(forKey: "lat") as? Double
                    let lon = value?.value(forKey: "lon") as? Double
                    let title = value?.value(forKey: "type") as? String
                    let subTitle = value?.value(forKey: "date") as? String
                    
                    let urlString = value?.value(forKey: "imageUrl") as? String
                    let url = URL(string: urlString!)
                    let data = try? Data(contentsOf: url!)
                    if(data != nil) {self.pinImages["\(lat!)"+"\(lon!)"] = UIImage(data: data!)}
                    self.pinIDs["\(lat!)"+"\(lon!)"] = post
                    
                    let pin: MKPointAnnotation = MKPointAnnotation()
                    pin.coordinate = CLLocationCoordinate2DMake(lat!, lon!)
                    pin.title = title
                    pin.subtitle = subTitle
                    self.map.addAnnotation(pin)
                }) { (error) in
                    print(error.localizedDescription)
                }
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    //custom pins(annotations) for the map view with pictures
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if !(annotation is MKPointAnnotation) {
            return nil
        }
        
        let annotationIdentifier = "AnnotationIdentifier"
        var annotationView = map.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            annotationView!.canShowCallout = true
        }
        else {
            annotationView!.annotation = annotation
        }
        
        let imageKey = "\(annotation.coordinate.latitude)"+"\(annotation.coordinate.longitude)"
        if(pinImages.count > 0) {annotationView!.image = pinImages[imageKey]}
        else {annotationView!.image = #imageLiteral(resourceName: "recenttick")}
        annotationView!.frame.size = CGSize(width: 30, height: 30)
        return annotationView
    }
    
    //This function controls behavor when a pin(annotation) is selected
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        mapView.deselectAnnotation(view.annotation, animated: false) //immediately deselect annotation
        let key = "\(view.annotation!.coordinate.latitude)"+"\(view.annotation!.coordinate.longitude)" //generate key from lat and lon
        let postController = storyboard?.instantiateViewController(withIdentifier: "Post") as! PostViewController //instantiate post controller
        postController.postId = "\(pinIDs[key]!)" //use key to give postId to controller
        navigationController?.pushViewController(postController, animated: true) //navigate to post view
    }
    
    //Required function to extend locationManager
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation:CLLocation = locations[0]
        
        let latitude = userLocation.coordinate.latitude
        let longitude = userLocation.coordinate.longitude
        
        let latDelta:CLLocationDegrees = 0.01
        
        let lonDelta:CLLocationDegrees = 0.01
        
        let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        
        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        
        let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        self.map.setRegion(region, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
