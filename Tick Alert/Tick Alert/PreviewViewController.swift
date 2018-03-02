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

    @IBAction func submitButton(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tickImage.image = uploadImage!
        tickTypeLabel.text = tickType!
        userLabel.text = "USER"
        locationLabel.text = "LOCATION"
        descriptionLabel.text = desc!
        let pin = MKPointAnnotation()
        pin.title = tickType!
        pin.subtitle = "DATE"
        pin.coordinate = location!
        map.addAnnotation(pin)
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(location!.latitude, location!.longitude), CLLocationDistance(1000), CLLocationDistance(1000))
        map.setRegion(coordinateRegion, animated: true)
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
