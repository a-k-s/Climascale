//
//  locationConfirmUpdateViewController.swift
//  Climascale
//
//  Created by Adrian Reilly on 4/19/21.
//

import UIKit
import MapKit
import CoreLocation

class locationConfirmUpdateViewController: UIViewController, MKMapViewDelegate {
    //picker
    @IBOutlet var vehiclePicker: UIPickerView!
    
    let vehicles = ["Car", "Suv", "Sedan/Wagon", "Truck", "TruckSuv", "Van", "PlugInHybrid", "BatteryElectric"]
    var myRow = 0
    //picker end

    override func viewDidLoad() {
        super.viewDidLoad()
        //picker
        vehiclePicker.dataSource = self
        vehiclePicker.delegate = self
        //

    }
    
    //update press
    @IBAction func updatePressLocations(_ sender: Any) {
        if myRow == 0 {
            print("car")
        }
        else if myRow == 1 {
            print("suv")
        }
        else if myRow == 2 {
            print("sedan")
        }
        else if myRow == 3 {
            print("truck")
        }
        else if myRow == 4 {
            print("trucksuv")
        }
        else if myRow == 5 {
            print("van")
        }
        else if myRow == 6 {
            print("plughybrid")
        }
        else if myRow == 7 {
            print("batteryElectric")
        }
        
        
    }
    //update Press end
    
   
    

 
}

extension locationConfirmUpdateViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return vehicles.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return vehicles[row]
    }
    
    //pickerview row
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        myRow = row
    }
    
    //pickerview row end
    
}





