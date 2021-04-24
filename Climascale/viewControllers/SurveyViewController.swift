//
//  SurveyViewController.swift
//  Climascale
//
//  Created by Adrian Reilly on 4/20/21.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import Firebase

public var weeklyGoal = 0.0

class SurveyViewController: UIViewController {
    
    var ref = Database.database().reference()
    let myFunctions = FunctionsSuper()
    
    @IBOutlet var vehiclePicker: UIPickerView!
    
    let vehicles = ["Car", "Truck", "PlugInHybrid/Electric"]
    var myRow = 0
    
    @IBOutlet var milesTextField: UITextField!
    @IBOutlet var daysTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        vehiclePicker.dataSource = self
        vehiclePicker.delegate = self

       
    }
    
    @IBAction func saveDataPress(_ sender: Any) {
        var dailyEmissions = 0.0
        if myRow == 0 {
            var miles = Double(milesTextField.text!) ?? 0
            dailyEmissions = 315 * miles
        } else if myRow == 1 {
            var miles = Double(milesTextField.text!) ?? 0
            dailyEmissions = 430.45 * miles
        }else if myRow == 2 {
            var miles = Double(milesTextField.text!) ?? 0
            dailyEmissions = 209 * miles
        }
        var weeklyEmissions = dailyEmissions * 7
        weeklyGoal = weeklyEmissions
        self.ref.child(self.myFunctions.getUidValue()).child("weeklygoal").setValue(weeklyGoal)
        
    }
    
    
    

}
extension SurveyViewController: UIPickerViewDataSource, UIPickerViewDelegate {
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
