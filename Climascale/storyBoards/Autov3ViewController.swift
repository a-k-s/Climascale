//
//  Autov3ViewController.swift
//  Climascale
//
//  Created by Adrian Reilly on 5/1/21.
//

import UIKit
import MapKit
import CoreLocation
import FirebaseAuth
import Firebase

public var latitude = CLLocationDegrees()
public var longitude = CLLocationDegrees()
public var startLatitudeForParameter = CLLocationDegrees()
public var startLongitudeForParameter = CLLocationDegrees()

public var endLatitudeForParameter = CLLocationDegrees()
public var endLongitudeForParameter = CLLocationDegrees()

class Autov3ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    //gradient
    var gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor(red: 0/255, green: 144/255, blue: 200/255, alpha: 1.0).cgColor, UIColor(red: 0/255, green: 170/255, blue: 170/255, alpha: 1.0).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        gradientLayer.frame = CGRect.zero
       return gradientLayer
    }()
    
    @IBOutlet weak var autoButton: UIButton!
    @IBOutlet weak var startAndEndCircle: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var chooseVehicleLabel: UILabel!
    
    var checkIfStartPress = false
    
    //location and timer
    var locationManager: CLLocationManager!
    var time = 0
    var timer = Timer()
    
    //stackviews
    @IBOutlet weak var hybridElectricStackView: UIStackView!
    @IBOutlet weak var carStackView: UIStackView!
    @IBOutlet weak var truckStackView: UIStackView!
    
    @IBOutlet weak var updateButtonAuto: RoundButton!
    var vehicleChoice = ""
    
    let myFunctions = FunctionsSuper()
    var ref = Database.database().reference()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.insertSublayer(gradientLayer, at: 0)
        gradientLayer.frame = view.bounds
        //add line
        var lineView = UIView(frame: CGRect(x: 0, y: autoButton.frame.size.height, width: autoButton.frame.size.width, height: 2))
        lineView.backgroundColor = UIColor(red: 254/255, green: 75/255, blue: 81/255, alpha: 1.0)
        autoButton.addSubview(lineView)
        checkIfStartPress = false
        //hide labels stackviews and update
        self.chooseVehicleLabel.isHidden = true
        
        self.hybridElectricStackView.isHidden = true
        self.carStackView.isHidden = true
        self.truckStackView.isHidden = true
        
        self.updateButtonAuto.isHidden = true
        
        //location delegates
        locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
       }

        
    }
    //timer action
    @objc func action() {
        time += 1
    }
    
    //start journey press
    @IBAction func AutoPress(_ sender: Any) {
        //variables
        let stopSymbol = UIImage(systemName: "stop.circle")
        let startSymbol = UIImage(systemName: "play.circle")
        
        //starting Journey
        if checkIfStartPress == false {
            startAndEndCircle.setBackgroundImage(stopSymbol, for: UIControl.State.normal)
            //request location and start timer
            print("startedJourney")
            locationManager.requestLocation()
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(Autov3ViewController.action), userInfo: nil, repeats: true)
            checkIfStartPress = true
            
            
        }
        //ending Journey
        else {
            print("You have ended a journey")
            locationManager.requestLocation()
            print("Time of: \(time)")
            timer.invalidate()
            time = 0
            startAndEndCircle.setBackgroundImage(startSymbol, for: UIControl.State.normal)
            checkIfStartPress = false
            self.chooseVehicleLabel.isHidden = false
            
            self.hybridElectricStackView.isHidden = false
            self.carStackView.isHidden = false
            self.truckStackView.isHidden = false
            
        }
        
    }
    //choose vehicle press
    @IBAction func hybridElectricPress(_ sender: Any) {
        vehicleChoice = "hybridElectricPress"
        self.carStackView.isHidden = true
        self.truckStackView.isHidden = true
        self.updateButtonAuto.isHidden = false
        
    }
    
    @IBAction func carButtonPress(_ sender: Any) {
        vehicleChoice = "car"
        self.truckStackView.isHidden = true
        self.hybridElectricStackView.isHidden = true
        self.updateButtonAuto.isHidden = false
        
    }
    
    @IBAction func TruckButtonPress(_ sender: Any) {
        vehicleChoice = "truck"
        self.hybridElectricStackView.isHidden = true
        self.carStackView.isHidden = true
        self.updateButtonAuto.isHidden = false
        
    }
    
    //location manager need function
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("error \(error.localizedDescription)")
    }
    
    //called evertime start and end Journey
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
       if let location = locations.first {
           latitude = location.coordinate.latitude
           longitude = location.coordinate.longitude
           //print(latitude)
           //print(longitude)
       }
       
       if checkIfStartPress == false {
           //latLabel.text = String(latitude)
           //longLabel.text = String(longitude)
        
           startLatitudeForParameter = latitude
           startLongitudeForParameter = longitude
        print(startLatitudeForParameter)
        print(startLongitudeForParameter)
       }
       else
       {
           //latLabelEnd.text = String(latitude)
           //longLabelEnd.text = String(longitude)
           endLatitudeForParameter = latitude
           endLongitudeForParameter = longitude
        print(endLatitudeForParameter)
        print(endLongitudeForParameter)
       }
   }
    
    
    
    
    
    //find eta and directions
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
                self.errorLabel.isHidden = false
                
            }
            return
        }
            if response.routes.count > 0
            {
                var sum = 0.0
                let route = response.routes[0]
                print("expected travelTime: \(route.expectedTravelTime)")
                print("distance \(route.distance)")
                expectedTimeInSeconds = route.expectedTravelTime
                let distanceMiles = (route.distance) * 0.00062137
                //calculate emissions
                if self.vehicleChoice == "hybridElectricPress" {
                    sum = distanceMiles * 200
                
                }
                else if self.vehicleChoice == "car" {
                    sum = distanceMiles * 315
                    
                }
                else if self.vehicleChoice == "truck" {
                    sum = distanceMiles * 430.45
                }
                //round the number
                let rounded = Double(round(10*sum)/10)
                //add commas
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .decimal
                let formattedNumber = numberFormatter.string(from: NSNumber(value:rounded))
                let alert = UIAlertController(title: "Confirm Update", message: "Are you sure you want to update your carbon emissions with \(String(formattedNumber ?? "nil")) kg?", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { action in
                    switch action.style {
                    case .default:
                        print("default")
                    case .cancel:
                        print("cancel")
                    case .destructive:
                        print("destructive")
                    }
                }))
                alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { action in
                    switch action.style {
                    case .default:
                        print("default")
                        //update carbon emissions in firebase
                        if Auth.auth().currentUser != nil {
                            self.ref.child(self.myFunctions.getUidValue()).child("totalcarbonemissions").getData { (error, snapshot) in
                                if let error = error {
                                    print("error getting data + \(error)")
                                }
                                else if snapshot.exists() {
                                    let currentTotal = snapshot.value! as? Double ?? 0.0
                                    let newTotal = currentTotal + sum
                                    let roundedTotal = Double(round(10*newTotal)/10)
                                    self.ref.child(self.myFunctions.getUidValue()).child("totalcarbonemissions").setValue(newTotal)
                                    //set journey logs
                                    let newRef = self.ref.child(self.myFunctions.getUidValue()).child("journeylogs").childByAutoId()
                                    newRef.setValue(roundedTotal)
                                    //let key = newRef.key
                                    //set day logs
                                    let date = Date()
                                    let dateFormatter = DateFormatter()
                                    dateFormatter.dateFormat = "EEEE"
                                    let dayOfTheWeekString = dateFormatter.string(from: date)
                                    let newRef2 = self.ref.child(self.myFunctions.getUidValue()).child("daylogs").childByAutoId()
                                    newRef2.setValue(dayOfTheWeekString)
                                    //set date logs
                                    let newRef3 = self.ref.child(self.myFunctions.getUidValue()).child("datelogs").childByAutoId()
                                    let fullDate = "\(date.get(.month))/\(date.get(.day))/\(date.get(.year))"
                                    newRef3.setValue(fullDate)
                                        DispatchQueue.main.async {
                                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "mainStart") as! UITabBarController
                                            vc.modalPresentationStyle = .fullScreen
                                            vc.modalTransitionStyle = .crossDissolve
                                            self.present(vc, animated: true, completion: nil)
                                        }
                                    
                                }
                                else {
                                    print("no data available")
                                }
                            }
                            
                        } else {
                            
                        }
                    case .cancel:
                        print("cancel")
                    case .destructive:
                        print("destructive")
                    }
                }))
                
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        return expectedTimeInSeconds
    }
    
    @IBAction func updatePress(_ sender: Any) {
        findMyETA(startLatitude: startLatitudeForParameter, startLongitude: startLatitudeForParameter, endLatitude: endLatitudeForParameter, endLongitude: endLongitudeForParameter)
        //findMyETA(startLatitude: 41.881832, startLongitude: -87.623177, endLatitude: 40.730610, endLongitude: -73.935242)
        
    }
    
    
    
    

 

}
