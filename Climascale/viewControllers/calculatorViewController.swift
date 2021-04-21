//
//  calculatorViewController.swift
//  Climascale
//
//  Created by Adrian Reilly on 4/14/21.
//


//get estimated time with function
//start a timer

//measure between two points

//endjourney run eta
//diference eta/subtract difference



//first thing you enter = car type
//enter number of miles
// update
//car = 315 g/m * miles 
import CoreLocation
import UIKit
import MapKit


class calculatorViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    //location variables
    var locationManager: CLLocationManager!

    @IBOutlet weak var latLabel: UILabel!
    
    @IBOutlet weak var longLabel: UILabel!
    
    
    @IBOutlet weak var latLabelEnd: UILabel!
    
    @IBOutlet weak var longLabelEnd: UILabel!
    
    var startJourneyPressedCheck = false
    
    //
    var startLatitudeForParameter = CLLocationDegrees()
    var startLongitudeForParameter = CLLocationDegrees()
    
    var endLatitudeForParameter = CLLocationDegrees()
    var endLongitudeForParameter = CLLocationDegrees()
    
    @IBOutlet weak var estimatedTimeLabel: UILabel!
    var latitude = CLLocationDegrees()
    var longitude = CLLocationDegrees()
    @IBOutlet weak var youHaveStartedJourney: UILabel!
    
    
    //picker view
    @IBOutlet var picker: UIPickerView!
    @IBOutlet var milesTextField: UITextField!
    @IBOutlet var updatedNumber: UILabel!
    let vehicles = ["Car", "Truck" ]
    let vehicleNumbers = [315, 430.45]
    var myRow = 0
    
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //location delegates
        locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            
       }
        //
        
        //picker
        picker.dataSource = self
        picker.delegate = self
        //
        
                
        
    }
    
    
    
    
    @IBAction func startJourneyPress(_ sender: Any) {
        
        youHaveStartedJourney.text = "You have started a journey"
        locationManager.requestLocation()
        startJourneyPressedCheck = false
        
    
        
    }
    
    @IBAction func endJourneyPress(_ sender: Any) {
        
        youHaveStartedJourney.text = "You have ended a journey"
        locationManager.requestLocation()
        startJourneyPressedCheck = true
        
    }
    
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
            latLabel.text = String(latitude)
            longLabel.text = String(longitude)
            startLatitudeForParameter = latitude
            startLongitudeForParameter = longitude
            
        }
        else
        {
            latLabelEnd.text = String(latitude)
            longLabelEnd.text = String(longitude)
            endLatitudeForParameter = latitude
            startLongitudeForParameter = longitude
            
        }
    }
   
    
    
  
    
    
   
    
    
    //picker
    @IBAction func updatePress(_ sender: Any) {
        if myRow == 0 {
            var miles = Double(milesTextField.text!)
            var finalVal = miles! * vehicleNumbers[0]
            updatedNumber.text = String(finalVal)
            myTotalEmissions = myTotalEmissions + finalVal
        }
        else if myRow == 1 {
            var miles = Double(milesTextField.text!)
            var finalVal = miles! * vehicleNumbers[1]
            updatedNumber.text = String(finalVal)
            myTotalEmissions = myTotalEmissions + finalVal
        }
        //gets rid of keyboard
        self.view.endEditing(true)
        
    }
    //
   
    //calculating ETA
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
            }
            return
        }
            if response.routes.count > 0
            {
                let route = response.routes[0]
                self.estimatedTimeLabel.text = String(route.expectedTravelTime)
                print(route.expectedTravelTime)
                expectedTimeInSeconds = route.expectedTravelTime
            }
        }
        
        return expectedTimeInSeconds
    }
    //
    
    @IBAction func updatePress2(_ sender: Any) {
        //var estimatedTime = findMyETA(startLatitude: startLatitudeForParameter, startLongitude: startLongitudeForParameter, endLatitude: endLatitudeForParameter, endLongitude: endLongitudeForParameter)
        var estimatedTime = findMyETA(startLatitude: startLatitudeForParameter, startLongitude: -89.52316149146252, endLatitude: 43.38817267682719, endLongitude: -89.54225588598246)
        //if estimatedTime != 0 {
            //estimatedTimeLabel.text = String(estimatedTime)
            
        //}
        //estimatedTimeLabel.text = String(estimatedTime)
        
    }

}

extension calculatorViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return vehicles.count
    }
    
    
}

extension calculatorViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        myRow = row
        return vehicles[row]
    }
    
}
