//
//  profileV2ViewController.swift
//  Climascale
//
//  Created by Adrian Reilly on 4/27/21.
//

import UIKit
import FirebaseAuth
import Firebase

class profileV2ViewController: UIViewController {
    var gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor(red: 0/255, green: 144/255, blue: 200/255, alpha: 1.0).cgColor, UIColor(red: 0/255, green: 170/255, blue: 170/255, alpha: 1.0).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        gradientLayer.frame = CGRect.zero
       return gradientLayer
    }()
    let myFunctions = FunctionsSuper()
    var ref = Database.database().reference()
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var signUpandLoginButton: UIButton!
    
    @IBOutlet weak var surveyLabel: UILabel!
    @IBOutlet weak var surveyButton: UIButton!
    
    //new baseline goal
    @IBOutlet var baselineTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.insertSublayer(gradientLayer, at: 0)
        gradientLayer.frame = view.bounds
        if Auth.auth().currentUser != nil {
            statusLabel.text = "Currently Logged In"
            signUpandLoginButton.isHidden = true
            surveyLabel.isHidden = true
            surveyButton.isHidden = true
            self.ref.child(myFunctions.getUidValue()).child("surveycheck").getData { (error, snapshot) in
                       if let error = error {
                           print("Error getting data \(error)")
                       }
                       else if snapshot.exists() {
                           let surveyCheck = snapshot.value! as? Double ?? -1
                        if surveyCheck == 0 {
                            DispatchQueue.main.async {
                                self.surveyLabel.isHidden = true
                                self.surveyButton.isHidden = true
                            }
                            
                        }
                            
                           
                       }
                       else {
                           print("No data available")
                       }
                   }
            
        } else {
            statusLabel.text = "You are currently not Logged In"
            signUpandLoginButton.isHidden = false
            self.surveyLabel.isHidden = true
            self.surveyButton.isHidden = true
            
        }
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)

    }
    
    @objc override func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Auth.auth().currentUser != nil {
            print("signed in")
            statusLabel.text = "Currently Logged In"
            signUpandLoginButton.isHidden = true
            //check for survey
            self.ref.child(myFunctions.getUidValue()).child("surveycheck").getData { (error, snapshot) in
                       if let error = error {
                           print("Error getting data \(error)")
                       }
                       else if snapshot.exists() {
                           let surveyCheck = snapshot.value! as? Double ?? -1
                        if surveyCheck == 0 {
                            DispatchQueue.main.async {
                                self.surveyLabel.isHidden = false
                                self.surveyButton.isHidden = false
                            }
                            
                        }
                            
                           
                       }
                       else {
                           print("No data available")
                       }
                   }
            
            
        }
        else {
            print("not signed in")
            statusLabel.text = "You are currently not Logged In"
            signUpandLoginButton.isHidden = false
            
        }
    }
    
    @IBAction func logOutPress(_ sender: Any) {
       do { try Auth.auth().signOut() }
        catch { print("already logged out") }
        let vc = storyboard?.instantiateViewController(withIdentifier: "mainStart") as! UITabBarController
        vc.modalPresentationStyle = .fullScreen
            DispatchQueue.main.async {
                self.present(vc, animated: false, completion: nil)
            }
        
        
    }
    
    
    @IBAction func surveyPress(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "startSurvey") as! UINavigationController
        vc.modalPresentationStyle = .fullScreen
            DispatchQueue.main.async {
                self.present(vc, animated: false, completion: nil)
            }
        
    }
    
    @IBAction func updateYourBaseLine(_ sender: Any) {
        var newBaseline = Double(baselineTextField.text!) ?? 0
        //round the number
        let rounded = Double(round(10*newBaseline)/10)
        //add commas
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let formattedNumber = numberFormatter.string(from: NSNumber(value:rounded))
        
        if Auth.auth().currentUser != nil {
            let alert = UIAlertController(title: "Confirm new baseline", message: "Are you sure you want you want to set baseline to \(String(formattedNumber ?? "nil")) kg?", preferredStyle: .alert)
            
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
                                self.ref.child(self.myFunctions.getUidValue()).child("weeklygoal").setValue(newBaseline)
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
            
        }else {
            
        }
    }
    
    
    
    
    
    
    

  

}
