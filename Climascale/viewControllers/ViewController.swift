//
//  ViewController.swift
//  Climascale
//
//  Created by Anton Schuster on 3/17/21.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import Firebase



public var myTotalEmissions = 0.0
public var publicToValue = 0.0
public var firstName = ""


class ViewController: UIViewController  {
    
    let myFunctions = FunctionsSuper()
    var ref = Database.database().reference()
    
   

    @IBOutlet weak var totalValue: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var weeklyGoalLabel: UILabel!
    
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Auth.auth().currentUser != nil {
            //set first name
            self.ref.child(myFunctions.getUidValue()).child("firstname").getData { (error, snapshot) in
                       if let error = error {
                           print("Error getting data \(error)")
                       }
                       else if snapshot.exists() {
                           firstName = snapshot.value! as? String ?? ""
                        DispatchQueue.main.async {
                            self.nameLabel.text = firstName
                        }
                           
                       }
                       else {
                           print("No data available")
                       }
                   }
            
            //set total
            self.ref.child(myFunctions.getUidValue()).child("totalcarbonemissions").getData { (error, snapshot) in
                if let error = error {
                    print("Error getting data \(error)")
                }
                else if snapshot.exists() {
                    myTotalEmissions = snapshot.value! as? Double ?? 0.0
                 DispatchQueue.main.async {
                     self.totalValue.text = String(myTotalEmissions) + " kg"
                 }
                    
                }
                else {
                    print("No data available")
                }
            }
            //set weekly and animate
            self.ref.child(myFunctions.getUidValue()).child("weeklygoal").getData { (error, snapshot) in
                if let error = error {
                    print("Error getting data \(error)")
                }
                else if snapshot.exists() {
                    weeklyGoal = snapshot.value! as? Double ?? 0.0
                 DispatchQueue.main.async {
                     self.weeklyGoalLabel.text = "Weekly goal of " + String(weeklyGoal) + " kg"
                     var percent = myTotalEmissions / weeklyGoal
                     percent = Double(round(100*percent)/100)
                     publicToValue = percent
                     animateIt(paramToValue: publicToValue)
                 }
                    
                }
                else {
                    print("No data available")
                }
            }
            
        } else {
            nameLabel.text = firstName
            totalValue.text = String(myTotalEmissions) + " kg"
            weeklyGoalLabel.text = "Weekly goal of " + String(weeklyGoal) + " kg"
            
        }
       
    
    }

 
        
    
    
    //unwind from cancel in manuelInput section of app
    @IBAction func unwindFromManualCarbonUpdate( _ seg: UIStoryboardSegue) {
    }
    //unwind from cancel in manuelInput section of app END
    

    
    
    
    
    
   

}



