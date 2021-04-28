//
//  ChooseVehicleViewController.swift
//  Climascale
//
//  Created by Adrian Reilly on 4/27/21.
//

import UIKit

public var vehicleChoice = 0
class ChooseVehicleViewController: UIViewController {
    
    @IBOutlet var vehiclePicker: UIPickerView!
    
    let vehicles = ["Car", "Truck", "PlugInHybrid"]
    var myRow = 0
    //picker end

    override func viewDidLoad() {
        super.viewDidLoad()
        vehiclePicker.dataSource = self
        vehiclePicker.delegate = self
        
    }
    
    @IBAction func continuePress(_ sender: Any) {
        vehicleChoice = myRow + 1
        
    }
    



}

extension ChooseVehicleViewController: UIPickerViewDataSource, UIPickerViewDelegate {
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
    
    
}
