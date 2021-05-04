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
public var weeklyGoal = 0.0


class ViewController: UIViewController  {
    
    let myFunctions = FunctionsSuper()
    var ref = Database.database().reference()
    
   

    @IBOutlet weak var totalValue: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var weeklyGoalLabel: UILabel!
    //gradient
    var gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor(red: 0/255, green: 144/255, blue: 200/255, alpha: 1.0).cgColor, UIColor(red: 0/255, green: 170/255, blue: 170/255, alpha: 1.0).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        gradientLayer.frame = CGRect.zero
       return gradientLayer
    }()
    
 
    
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.insertSublayer(gradientLayer, at: 0)
        gradientLayer.frame = view.bounds
        
    
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
            firstName = ""
            myTotalEmissions = 0.0
            weeklyGoal = 0.0
            
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




