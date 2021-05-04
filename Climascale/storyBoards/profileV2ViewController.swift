//
//  profileV2ViewController.swift
//  Climascale
//
//  Created by Adrian Reilly on 4/27/21.
//

import UIKit
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
    
    
    

  

}
