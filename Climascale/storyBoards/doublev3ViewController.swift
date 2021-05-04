//
//  doublev3ViewController.swift
//  Climascale
//
//  Created by Adrian Reilly on 5/1/21.
//

import UIKit
import FirebaseAuth
import Firebase

class doublev3ViewController: UIViewController {
    //gradient
    var gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor(red: 0/255, green: 144/255, blue: 200/255, alpha: 1.0).cgColor, UIColor(red: 0/255, green: 170/255, blue: 170/255, alpha: 1.0).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        gradientLayer.frame = CGRect.zero
       return gradientLayer
    }()
    
    @IBOutlet weak var manualButton: UIButton!
    
    @IBOutlet var carTextField: UITextField!
    @IBOutlet var suvTextField: UITextField!
    @IBOutlet var sedanWagonTextField: UITextField!
    @IBOutlet var truckTextField: UITextField!
    @IBOutlet var truckSuvTextField: UITextField!
    @IBOutlet var vanTextField: UITextField!
    @IBOutlet var plugInHybridTextField: UITextField!
    @IBOutlet var batteryElectricTextField: UITextField!
    @IBOutlet var trainTextField: UITextField!
    @IBOutlet var busTextField: UITextField!
    
    let myFunctions = FunctionsSuper()
    var ref = Database.database().reference()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.insertSublayer(gradientLayer, at: 0)
        gradientLayer.frame = view.bounds
        var lineView = UIView(frame: CGRect(x: 0, y: manualButton.frame.size.height, width: manualButton.frame.size.width, height: 2))
        lineView.backgroundColor = UIColor(red: 254/255, green: 75/255, blue: 81/255, alpha: 1.0)
        manualButton.addSubview(lineView)
        
        //testing
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)

    }
    
    @objc override func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    @IBAction func updatePress(_ sender: Any) {
        //calculate sum and emissions
        let one = self.calculateEmissions(vehicle: "Car", numberOfMiles: Double(self.carTextField.text!) ?? 0)
        let two = self.calculateEmissions(vehicle: "Suv", numberOfMiles: Double(self.suvTextField.text!) ?? 0)
        let three = self.calculateEmissions(vehicle: "Sedan/Wagon", numberOfMiles: Double(self.sedanWagonTextField.text!) ?? 0)
        let four = self.calculateEmissions(vehicle: "Truck", numberOfMiles: Double(self.truckTextField.text!) ?? 0)
        let five = self.calculateEmissions(vehicle: "TruckSuv", numberOfMiles: Double(self.truckSuvTextField.text!) ?? 0)
        let six = self.calculateEmissions(vehicle: "Van", numberOfMiles: Double(self.vanTextField.text!) ?? 0)
        let seven = self.calculateEmissions(vehicle: "PlugInHybrid", numberOfMiles: Double(self.plugInHybridTextField.text!) ?? 0)
        let eight = self.calculateEmissions(vehicle: "BatteryElectric", numberOfMiles: Double(self.batteryElectricTextField.text!) ?? 0)
        let nine = self.calculateEmissions(vehicle: "Train", numberOfMiles: Double(self.trainTextField.text!) ?? 0)
        let ten = self.calculateEmissions(vehicle: "Bus", numberOfMiles: Double(self.busTextField.text!) ?? 0)
        let sum = one + two + three + four + five + six + seven + eight + nine + ten
        //round the number
        let rounded = Double(round(10*sum)/10)
        //add commas
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let formattedNumber = numberFormatter.string(from: NSNumber(value:rounded))
        let alert = UIAlertController(title: "Confirm Update", message: "Are you sure you want to update your carbon emissions with \(String(formattedNumber ?? "nil")) kg?", preferredStyle: .alert)
        
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
                //update carbon emissions in firebase
                if Auth.auth().currentUser != nil {
                    self.ref.child(self.myFunctions.getUidValue()).child("totalcarbonemissions").getData { (error, snapshot) in
                        if let error = error {
                            print("error getting data + \(error)")
                        }
                        else if snapshot.exists() {
                            let currentTotal = snapshot.value! as? Double ?? 0.0
                            let newTotal = currentTotal + sum
                            let roundedTotal = Double(round(10*newTotal)/10)
                            self.ref.child(self.myFunctions.getUidValue()).child("totalcarbonemissions").setValue(newTotal)
                            //set journey logs
                            let newRef = self.ref.child(self.myFunctions.getUidValue()).child("journeylogs").childByAutoId()
                            newRef.setValue(roundedTotal)
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
                                DispatchQueue.main.async {
                                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "mainStart") as! UITabBarController
                                    vc.modalPresentationStyle = .fullScreen
                                    vc.modalTransitionStyle = .crossDissolve
                                    self.present(vc, animated: true, completion: nil)
                                }
                            
                        }
                        else {
                            print("no data available")
                        }
                    }
                    
                } else {
                    
                }
            case .cancel:
                print("cancel")
            case .destructive:
                print("destructive")
            }
        }))
        
        self.present(alert, animated: true, completion: nil)
        
        
        
                
    }
    
    @IBAction func unwindFromAuto( _ seg: UIStoryboardSegue) {
    }
    
    //calculate emissions for each vehicle
    func calculateEmissions(vehicle: String, numberOfMiles: Double) -> Double {
        if vehicle == "Car"
        {
            return 315 * numberOfMiles
        }
        else if vehicle == "Suv"
        {
            return 349.45 * numberOfMiles
        }
        else if vehicle == "Sedan/Wagon"
        {
            return 307 * numberOfMiles
        }
        else if vehicle == "Truck"
        {
            return 430.45 * numberOfMiles
        }
        else if vehicle == "TruckSuv"
        {
            return 410.81 * numberOfMiles
        }
        else if vehicle == "Van"
        {
            return 411.55 * numberOfMiles
        }
        else if vehicle == "PlugInHybrid"
        {
            return 209 * numberOfMiles
        }
        else if vehicle == "BatteryElectric"
        {
            return 154 * numberOfMiles
        }
        else if vehicle == "Train"
        {
            return 99.79 * numberOfMiles
        }
        else if vehicle == "Bus"
        {
            return 290.299 * numberOfMiles
        }
        else
        {
            return 0
        }
    }
    


}
