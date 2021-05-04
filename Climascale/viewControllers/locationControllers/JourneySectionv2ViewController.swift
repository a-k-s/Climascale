//
//  JourneySectionv2ViewController.swift
//  Climascale
//
//  Created by Adrian Reilly on 4/27/21.
//

import UIKit
import MapKit
import CoreLocation
import FirebaseDatabase

//public var latitude = CLLocationDegrees()
//public var longitude = CLLocationDegrees()
//public var startLatitudeForParameter = CLLocationDegrees()
//public var startLongitudeForParameter = CLLocationDegrees()

//public var endLatitudeForParameter = CLLocationDegrees()
//public var endLongitudeForParameter = CLLocationDegrees()

class JourneySectionv2ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    var locationManager: CLLocationManager!
    //location manager variable end
    
    //checking to see if start journey was pressed
    var startJourneyPressedCheck = false
    //checking to see if start journey was pressed end
    
    //timer variables
    var time = 0
    var timer = Timer()
    
    @IBOutlet weak var statusJourneyLabel: UILabel!
    
    @IBOutlet weak var startJourneyButton: UIButton!
    @IBOutlet weak var updateButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateButton.isHidden = true
        locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            
       }

       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    
    @IBAction func startJourneyPress(_ sender: Any) {
        statusJourneyLabel.text = "Journey In Progress"
        self.startJourneyButton.isHidden = true
        
        //youHaveStartedJourney.text = "You have started a journey"
        print("You have started a journey")
        locationManager.requestLocation()
        startJourneyPressedCheck = false
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(JourneySectionv2ViewController.action), userInfo: nil, repeats: true)
    }
    //start journey press end
    
    //end journey press
    @IBAction func endJourneyPress(_ sender: Any) {
        
        //youHaveStartedJourney.text = "You have started a journey"
        self.startJourneyButton.isHidden = false
        self.updateButton.isHidden = false
        print("You have ended a journey")
        locationManager.requestLocation()
        startJourneyPressedCheck = true
        print("Time of: \(time)")
        timer.invalidate()
        time = 0
    }
    
    
    @objc func action() {
        time += 1
    }
    //timer action end
    
    //location manager functions
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("error \(error.localizedDescription)")
    }
    
     func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            latitude = location.coordinate.latitude
            longitude = location.coordinate.longitude
            print(latitude)
            print(longitude)
        }
        
        if startJourneyPressedCheck == false {
            //latLabel.text = String(latitude)
            //longLabel.text = String(longitude)
            startLatitudeForParameter = latitude
            startLongitudeForParameter = longitude
            
        }
        else
        {
            //latLabelEnd.text = String(latitude)
            //longLabelEnd.text = String(longitude)
            endLatitudeForParameter = latitude
            startLongitudeForParameter = longitude
            
        }
    }
    //location manager functions end
    
    //update first press
    @IBAction func updatePressLocations(_ sender: Any) {
        var timeInSeconds = findMyETA(startLatitude: startLatitudeForParameter, startLongitude: startLongitudeForParameter, endLatitude: endLatitudeForParameter, endLongitude: endLongitudeForParameter)
        //var timeInSeconds = findMyETA(startLatitude: 41.881832, startLongitude: -87.623177, endLatitude: 43.073051, endLongitude: -89.401230) //chi to madi
        //var timeInSeconds = findMyETA(startLatitude: 43.387808399315354, startLongitude: -89.54210291624958, endLatitude: 43.40627251662631, endLongitude: -89.51493230656675) wisco cords
    }
    //update first press end
    
    //find ETA and distance in meters
    func findMyETA (startLatitude: CLLocationDegrees, startLongitude: CLLocationDegrees, endLatitude: CLLocationDegrees, endLongitude: CLLocationDegrees) -> Double
    {
        var expectedTimeInSeconds = 0.0
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: startLatitude, longitude: startLongitude), addressDictionary: nil))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: endLatitude, longitude: endLongitude), addressDictionary: nil))
        request.requestsAlternateRoutes = true
        request.transportType = .automobile
        
        let directions = MKDirections(request: request)
        directions.calculate {(response, error) -> Void in
        guard let response = response else {
            if let error = error {
                print("Error \(error)")
                //popup alert add
                self.statusJourneyLabel.text = "Error Please Enter Manually"
            }
            return
        }
            if response.routes.count > 0
            {
                let route = response.routes[0]
                print("expected travelTime: \(route.expectedTravelTime)")
                print("distance \(route.distance)")
                expectedTimeInSeconds = route.expectedTravelTime
                self.performSegue(withIdentifier: "foundDirectionsID", sender: nil)
            }
        }
        
        return expectedTimeInSeconds
    }
    



}
