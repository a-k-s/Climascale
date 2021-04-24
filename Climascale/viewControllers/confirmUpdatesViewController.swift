//
//  confirmUpdatesViewController.swift
//  Climascale
//
//  Created by Adrian Reilly on 4/17/21.
//

//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import Firebase

class confirmUpdatesViewController: UIViewController {
    //labels for confirmation segue
    @IBOutlet weak var carLabelNumber: UILabel!
    @IBOutlet weak var suvLabelNumber: UILabel!
    @IBOutlet weak var sedanWagonLabelNumber: UILabel!
    @IBOutlet weak var truckLabelNumber: UILabel!
    @IBOutlet weak var truckSuvLabelNumber: UILabel!
    @IBOutlet weak var vanLabelNumber: UILabel!
    @IBOutlet weak var plugInHybridLabelNumber: UILabel!
    @IBOutlet weak var batteryElectricLabelNumber: UILabel!
    @IBOutlet weak var trainLabelNumber: UILabel!
    @IBOutlet weak var busLabelNumber: UILabel!
    
    //labels for confirmation segue end
    
    let myFunctions = FunctionsSuper()
    var ref = Database.database().reference()

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        carLabelNumber.text = String(carOutputNumber)
        suvLabelNumber.text = String(suvOutputNumber)
        sedanWagonLabelNumber.text = String(sedanWagonOutputNumber)
        truckLabelNumber.text = String(truckOutputNumber)
        truckSuvLabelNumber.text = String(truckSuvOutputNumber)
        vanLabelNumber.text = String(vanOutputNumber)
        plugInHybridLabelNumber.text = String(plugInHybridOutputNumber)
        batteryElectricLabelNumber.text = String(batteryElectricOutputNumber)
        trainLabelNumber.text = String(trainOutputNumber)
        busLabelNumber.text = String(busOutputNumber)
    }
    
    @IBAction func confirmUpdatePress(_ sender: Any) {
        var mySum = 0.0
        mySum += carOutputNumber
        mySum += suvOutputNumber
        mySum += sedanWagonOutputNumber
        mySum += truckOutputNumber
        mySum += truckSuvOutputNumber
        mySum += vanOutputNumber
        mySum += plugInHybridOutputNumber
        mySum += batteryElectricOutputNumber
        mySum += trainOutputNumber
        mySum += busOutputNumber
        
        self.ref.child(myFunctions.getUidValue()).child("totalcarbonemissions").getData { (error, snapshot) in
            if let error = error {
                print("error getting data + \(error)")
            }
            else if snapshot.exists() {
                let currentTotal = snapshot.value! as? Double ?? 0.0
                let newTotal = currentTotal + mySum
                self.ref.child(self.myFunctions.getUidValue()).child("totalcarbonemissions").setValue(newTotal)
                //set journey logs
                let newRef = self.ref.child(self.myFunctions.getUidValue()).child("journeylogs").childByAutoId()
                newRef.setValue(mySum)
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
                
            }
            else {
                print("no data available")
            }
        }
        carOutputNumber = 0.0
        suvOutputNumber = 0.0
        sedanWagonOutputNumber = 0.0
        truckOutputNumber = 0.0
        truckSuvOutputNumber = 0.0
        vanOutputNumber = 0.0
        plugInHybridOutputNumber = 0.0
        batteryElectricOutputNumber = 0.0
        trainOutputNumber = 0.0
        busOutputNumber = 0.0
        
        
    }
    
    

}

extension Date {
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }

    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}


