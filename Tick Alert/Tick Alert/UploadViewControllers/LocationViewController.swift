//
//  LocationViewController.swift
//  Tick Alert
//
//  Created by David Freeman on 3/1/18.
//  Copyright © 2018 David Freeman. All rights reserved.
//

import UIKit
import MapKit

class LocationViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet var centerMapButton: UIButton!
    var tickType: String?
    var desc: String?
    var uploadImage: UIImage?
    var sex: String?
    var ornation: String?
    var capitulum: String?
    var whereFound: String?

    var userLocation: CLLocation?
    var pin: MKPointAnnotation = MKPointAnnotation()
    @IBOutlet var map: MKMapView!
    var locationManager = CLLocationManager()
    var locationSelected = false
    
    @IBAction func centerButtonPressed(_ sender: Any) {
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
        
        pin.title = tickType!
        
        let nextButton = UIBarButtonItem(title: "Next", style: UIBarButtonItemStyle.plain, target: self, action: #selector(nextButtonPressed))
        self.navigationItem.rightBarButtonItem = nextButton
        
        let uitgr = UITapGestureRecognizer(target: self, action: #selector(LocationViewController.action(_:)))
        map.addGestureRecognizer(uitgr)
        map.mapType = .hybrid
    }
    
    @objc func nextButtonPressed() {
        if(!locationSelected) {return}
        
        let previewController = storyboard?.instantiateViewController(withIdentifier: "Preview") as! PreviewViewController
        previewController.uploadImage = uploadImage
        previewController.tickType = tickType
        previewController.sex = sex
        previewController.ornation = ornation
        previewController.capitulum = capitulum
        previewController.desc = desc
        previewController.whereFound = whereFound
        previewController.location = pin.coordinate
        navigationController?.pushViewController(previewController, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLocation = locations[0]
        let latitude = userLocation!.coordinate.latitude
        let longitude = userLocation!.coordinate.longitude
        let latDelta:CLLocationDegrees = 0.01
        let lonDelta:CLLocationDegrees = 0.01
        let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        self.map.setRegion(region, animated: true)
    }
    
    @objc func action(_ gestureRecognizer:UIGestureRecognizer) {
        locationSelected = true
        let touchPoint = gestureRecognizer.location(in: self.map)
        let newCoordinate:CLLocationCoordinate2D = map.convert(touchPoint, toCoordinateFrom: self.map)
        pin.coordinate = newCoordinate
        map.addAnnotation(pin)
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
