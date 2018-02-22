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
    
    @IBAction func centerOnLocationButtonPress(_ sender: Any) {
        locationManager.startUpdatingLocation()
        locationManager.stopUpdatingLocation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.stopUpdatingLocation()
        
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
                    self.pinImages["\(lat!)"+"\(lon!)"] = UIImage(data: data!)
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
        annotationView!.image = pinImages[imageKey]
        annotationView!.frame.size = CGSize(width: 30, height: 30)
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        mapView.deselectAnnotation(view.annotation, animated: false)
        let key = "\(view.annotation!.coordinate.latitude)"+"\(view.annotation!.coordinate.longitude)"
        let postController = storyboard?.instantiateViewController(withIdentifier: "Post") as! PostViewController
        postController.postId = "\(pinIDs[key]!)"
        navigationController?.pushViewController(postController, animated: true)
    }
    
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
