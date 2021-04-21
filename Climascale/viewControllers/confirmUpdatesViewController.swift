//
//  confirmUpdatesViewController.swift
//  Climascale
//
//  Created by Adrian Reilly on 4/17/21.
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
        journeyLogs.append(mySum)
        
        self.ref.child(myFunctions.getUidValue()).child("totalcarbonemissions").getData { (error, snapshot) in
            if let error = error {
                print("error getting data")
            }
            else if snapshot.exists() {
                var currentTotal = snapshot.value! as? Double ?? 0.0
                var newTotal = currentTotal + mySum
                self.ref.child(self.myFunctions.getUidValue()).child("totalcarbonemissions").setValue(newTotal)
            }
            else {
                print("no data available")
            }
        }
        
        
    }
    
    
    
    
    

  

}
