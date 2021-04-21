//
//  calculatorViewControllerV2.swift
//  Climascale
//
//  Created by Adrian Reilly on 4/17/21.
//

import UIKit
import MapKit
import CoreLocation
import FirebaseDatabase

//public output numbers for confirm segue
public var carOutputNumber = 0.0
public var suvOutputNumber = 0.0
public var sedanWagonOutputNumber = 0.0
public var truckOutputNumber = 0.0
public var truckSuvOutputNumber = 0.0
public var vanOutputNumber = 0.0
public var plugInHybridOutputNumber = 0.0
public var batteryElectricOutputNumber = 0.0
public var trainOutputNumber = 0.0
public var busOutputNumber = 0.0
//public output numbers for confirm segue end

//public location variables
public var latitude = CLLocationDegrees()
public var longitude = CLLocationDegrees()
public var startLatitudeForParameter = CLLocationDegrees()
public var startLongitudeForParameter = CLLocationDegrees()

public var endLatitudeForParameter = CLLocationDegrees()
public var endLongitudeForParameter = CLLocationDegrees()
//public location variables end

class calculatorViewControllerV2: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    //textFields for input calculator
    @IBOutlet var carTextField: UITextField!
    @IBOutlet var suvTextField: UITextField!
    @IBOutlet var sedanWagonTextField: UITextField!
    @IBOutlet var truckTextField: UITextField!
    @IBOutlet var truckSuvTextField: UITextField!
    @IBOutlet var vanTextField: UITextField!
    @IBOutlet var plugInHybridTextField: UITextField!
    @IBOutlet var batteryElectricTextField: UITextField!
    @IBOutlet var trainTextField: UITextField!
    @IBOutlet var busTextField: UITextField!
    //end textFields for input calculator
    
    //location manager variable
    var locationManager: CLLocationManager!
    //location manager variable end
    
    //checking to see if start journey was pressed
    var startJourneyPressedCheck = false
    //checking to see if start journey was pressed end
    
    //timer variables
    var time = 0
    var timer = Timer()
    
    //timer variables end
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //location manager setting delegate
        locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            
       }
        //location manager setting delegate end

        
    }
    
    
    
    //manualInputUpdatePress
    @IBAction func manualInputUpdatePress(_ sender: Any) {
        let carInputNumber = Double(carTextField.text!) ?? 0
        let suvInputNumber = Double(suvTextField.text!) ?? 0
        let sedanWagonInputNumber = Double(sedanWagonTextField.text!) ?? 0
        let truckInputNumber = Double(truckTextField.text!) ?? 0
        let truckSuvInputNumber = Double(truckSuvTextField.text!) ?? 0
        let vanInputNumber = Double(vanTextField.text!) ?? 0
        let plugInHybridInputNumber = Double(plugInHybridTextField.text!) ?? 0
        let batteryElectricInputNumber = Double(batteryElectricTextField.text!) ?? 0
        let trainInputNumber = Double(trainTextField.text!) ?? 0
        let busInputNumber = Double(busTextField.text!) ?? 0
        
        carOutputNumber = calculateEmissions(vehicle: "Car", numberOfMiles: carInputNumber)
        suvOutputNumber = calculateEmissions(vehicle: "Suv", numberOfMiles: suvInputNumber)
        sedanWagonOutputNumber = calculateEmissions(vehicle: "Sedan/Wagon", numberOfMiles: sedanWagonInputNumber)
        truckOutputNumber = calculateEmissions(vehicle: "Truck", numberOfMiles: truckInputNumber)
        truckSuvOutputNumber = calculateEmissions(vehicle: "TruckSuv", numberOfMiles: truckSuvInputNumber)
        vanOutputNumber = calculateEmissions(vehicle: "Van", numberOfMiles: vanInputNumber)
        plugInHybridOutputNumber = calculateEmissions(vehicle: "PlugInHybrid", numberOfMiles: plugInHybridInputNumber)
        batteryElectricOutputNumber = calculateEmissions(vehicle: "BatteryElectric", numberOfMiles: batteryElectricInputNumber)
        trainOutputNumber = calculateEmissions(vehicle: "Train", numberOfMiles: trainInputNumber)
        busOutputNumber = calculateEmissions(vehicle: "Bus", numberOfMiles: busInputNumber)
        
    }
    //ManuelInputUpdatePressEnd
    
    //unwind from confirmCarbonUpdate
    @IBAction func unwindFromConfirmCarbonUpdate( _ seg: UIStoryboardSegue) {
    }
    
    //unwind from confirmCarbonUpdate End
    
    //function for each vehicle
    func calculateEmissions(vehicle: String, numberOfMiles: Double) -> Double {
        if vehicle == "Car"
        {
            return 315 * numberOfMiles
        }
        else if vehicle == "Suv"
        {
            return 349.45 * numberOfMiles
        }
        else if vehicle == "Sedan/Wagon"
        {
            return 307 * numberOfMiles
        }
        else if vehicle == "Truck"
        {
            return 459.27 * numberOfMiles
        }
        else if vehicle == "TruckSuv"
        {
            return 410.81 * numberOfMiles
        }
        else if vehicle == "Van"
        {
            return 411.55 * numberOfMiles
        }
        else if vehicle == "PlugInHybrid"
        {
            return 209 * numberOfMiles
        }
        else if vehicle == "BatteryElectric"
        {
            return 154 * numberOfMiles
        }
        else if vehicle == "Train"
        {
            return 99.79 * numberOfMiles
        }
        else if vehicle == "Bus"
        {
            return 290.299 * numberOfMiles
        }
        else
        {
            return 0
        }
    }
    //function for each vehicle end
    
    //start Journey Press
    @IBAction func startJourneyPress(_ sender: Any) {
        
        //youHaveStartedJourney.text = "You have started a journey"
        print("You have started a journey")
        locationManager.requestLocation()
        startJourneyPressedCheck = false
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(calculatorViewControllerV2.action), userInfo: nil, repeats: true)
    }
    //start journey press end
    
    //end journey press
    @IBAction func endJourneyPress(_ sender: Any) {
        
        //youHaveStartedJourney.text = "You have started a journey"
        print("You have ended a journey")
        locationManager.requestLocation()
        startJourneyPressedCheck = true
        print("Time of: \(time)")
        timer.invalidate()
        time = 0
    }
    //end journey press end
    
    //timer action
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
            }
            return
        }
            if response.routes.count > 0
            {
                let route = response.routes[0]
                print("expected travelTime: \(route.expectedTravelTime)")
                print("distance \(route.distance)")
                expectedTimeInSeconds = route.expectedTravelTime
            }
        }
        
        return expectedTimeInSeconds
    }
    //find ETA and distance in meters end
    
    
        
    

   
}
