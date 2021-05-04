//
//  InitialSurvey3ViewController.swift
//  Climascale
//
//  Created by Adrian Reilly on 4/26/21.
//

import UIKit

public var baselineLabelNumber = ""

class InitialSurvey3ViewController: UIViewController {
    
    @IBOutlet var dayPicker: UIPickerView!
    let dayArray = ["1", "2", "3", "4", "5", "6", "7"]
    var myRow = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        dayPicker.dataSource = self
        dayPicker.delegate = self
    }
    
    @IBAction func nextQuestion3Press(_ sender: Any) {
        var dailyEmissions = 0.0
        var weeklyEmissions = 0.0
        if vehicleSurvey == "Car" {
            dailyEmissions = 315 * averageMilesSurvey
        } else if vehicleSurvey == "Truck" {
            dailyEmissions = 430.45 * averageMilesSurvey
        } else if vehicleSurvey == "PlugInHybrid/Electric" {
            dailyEmissions = 209 * averageMilesSurvey
        }
        if myRow == 0 {
            numberOfDaysSurvey = 1
            weeklyEmissions = 1 * dailyEmissions
        }
        else if myRow == 1 {
            numberOfDaysSurvey = 2
            weeklyEmissions = 2 * dailyEmissions
        }
        else if myRow == 2 {
            numberOfDaysSurvey = 3
            weeklyEmissions = 3 * dailyEmissions
        }
        else if myRow == 3 {
            numberOfDaysSurvey = 4
            weeklyEmissions = 4 * dailyEmissions
        }
        else if myRow == 4 {
            numberOfDaysSurvey = 5
            weeklyEmissions = 5 * dailyEmissions
        }
        else if myRow == 5 {
            numberOfDaysSurvey = 6
            weeklyEmissions = 6 * dailyEmissions
        }
        else if myRow == 6 {
            numberOfDaysSurvey = 7
            weeklyEmissions = 7 * dailyEmissions
        }
        //round the number
        let rounded = Double(round(10*weeklyEmissions)/10)
        //add commas
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let formattedNumber = numberFormatter.string(from: NSNumber(value:rounded))
        baselineLabelNumber = formattedNumber ?? "0"
        
        startBaseLine = weeklyEmissions
        
    }
    

 

}

extension InitialSurvey3ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dayArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dayArray[row]
    }
    
    //pickerview row
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        myRow = row
    }
    
    
}
