//
//  IntialSurveyViewController.swift
//  Climascale
//
//  Created by Adrian Reilly on 4/26/21.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import Firebase

public var vehicleSurvey = ""
public var averageMilesSurvey = 0.0
public var numberOfDaysSurvey = 0.0
public var startBaseLine = 0.0
public var tookSurvey = false


class IntialSurveyViewController: UIViewController {
    
    @IBOutlet var vehiclePicker: UIPickerView!
    let vehicles = ["Car", "Truck", "PlugInHybrid/Electric"]
    var myRow = 0
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
        vehiclePicker.dataSource = self
        vehiclePicker.delegate = self

    }
  
    
    @IBAction func nextQuestion1Press(_ sender: Any) {
        if myRow == 0 {
            print("row1")
            vehicleSurvey = "Car"
            
        }
        else if myRow == 1 {
            print("row2")
            vehicleSurvey = "Truck"
        }
        else if myRow == 2 {
            print("row3")
            vehicleSurvey = "PlugInHybrid/Electric"
        }
    }
    
   

}

extension IntialSurveyViewController: UIPickerViewDataSource, UIPickerViewDelegate {
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
