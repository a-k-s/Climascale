//
//  mainViewV2ViewController.swift
//  Climascale
//
//  Created by Adrian Reilly on 5/3/21.
//

import UIKit
import FirebaseAuth
import Firebase

class mainViewV2ViewController: UIViewController {
    //gradient
    var gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor(red: 0/255, green: 144/255, blue: 200/255, alpha: 1.0).cgColor, UIColor(red: 0/255, green: 170/255, blue: 170/255, alpha: 1.0).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        gradientLayer.frame = CGRect.zero
       return gradientLayer
    }()
    
    //labels
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var weeklyGoalLabel: UILabel!
    @IBOutlet weak var totalThisWeek: UILabel!
    @IBOutlet weak var backgroundLabel: UILabel!
    
    
    @IBOutlet weak var viewOnTop: UIView!
    @IBOutlet weak var addButton: UIButton!
    
    let myFunctions = FunctionsSuper()
    var ref = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.insertSublayer(gradientLayer, at: 0)
        gradientLayer.frame = view.bounds
        //round corners of view
        viewOnTop.layer.cornerRadius = 40
        viewOnTop.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        weeklyGoalLabel.layer.cornerRadius = 16
        weeklyGoalLabel.layer.masksToBounds = true
        backgroundLabel.layer.cornerRadius = 16
        backgroundLabel.layer.masksToBounds = true
        addButton.layer.cornerRadius = 16

       
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
            
            //set total this week
            self.ref.child(myFunctions.getUidValue()).child("totalcarbonemissions").getData { (error, snapshot) in
                if let error = error {
                    print("Error getting data \(error)")
                }
                else if snapshot.exists() {
                    myTotalEmissions = snapshot.value! as? Double ?? 0.0
                    //round the number
                    let rounded = Double(round(10*myTotalEmissions)/10)
                    //add commas
                    let numberFormatter = NumberFormatter()
                    numberFormatter.numberStyle = .decimal
                    let formattedNumber = numberFormatter.string(from: NSNumber(value:rounded))
                 DispatchQueue.main.async {
                    //this in circle
                    self.totalThisWeek.text = String(formattedNumber ?? "nil") + " kg"
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
                    //round the number
                    let rounded = Double(round(10*weeklyGoal)/10)
                    //add commas
                    let numberFormatter = NumberFormatter()
                    numberFormatter.numberStyle = .decimal
                    let formattedNumber = numberFormatter.string(from: NSNumber(value:rounded))
                 DispatchQueue.main.async {
                     self.weeklyGoalLabel.text = String(formattedNumber ?? "nil") + " kg"
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
           // totalValue.text = String(myTotalEmissions) + " kg"
            weeklyGoalLabel.text = "Weekly goal of " + String(weeklyGoal) + " kg"
            
        }
       
    }
    
    
    @IBAction func subtractPress(_ sender: Any) {
        let alert = UIAlertController(title: "Confirm baseline subtraction", message: "Are you sure you want to subtract your weekly base line by 5 percent?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { action in
            switch action.style {
            case .default:
                print("default")
            case .cancel:
                print("cancel")
            case .destructive:
                print("destructive")
            }
        }))
        alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { action in
            switch action.style {
            case .default:
                print("default")
                //sets new weekly goal and resets total
                if Auth.auth().currentUser != nil  {
                    self.ref.child(self.myFunctions.getUidValue()).child("weeklygoal").getData { (error, snapshot) in
                        if let error = error {
                            print(error)
                        }
                        else if snapshot.exists() {
                            let weeklyGoal = snapshot.value! as? Double ?? 0.0
                            let fivePercent = 0.05 * weeklyGoal
                            let newBaseLine = weeklyGoal - fivePercent
                            self.ref.child(self.myFunctions.getUidValue()).child("weeklygoal").setValue(newBaseLine)
                            self.ref.child(self.myFunctions.getUidValue()).child("totalcarbonemissions").setValue(0)
                            DispatchQueue.main.async {
                                let vc = self.storyboard?.instantiateViewController(withIdentifier: "mainStart") as! UITabBarController
                                vc.modalPresentationStyle = .fullScreen
                                vc.modalTransitionStyle = .crossDissolve
                                self.present(vc, animated: true, completion: nil)
                            }
                            
                        }
                        else {
                            print("no data")
                        }
                    }
                }
                else {
                    
                }
                //if logged in
                //set weekly goal to minus 5 percent of baseline
                //set total back to 0
            case .cancel:
                print("cancel")
            case .destructive:
                print("destructive")
            }
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    

  

}


extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
