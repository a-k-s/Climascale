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

//public location variables end

class calculatorViewControllerV2: UIViewController {
    
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
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
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
    

   
}
