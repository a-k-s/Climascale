//
//  InitialSurvey4ViewController.swift
//  Climascale
//
//  Created by Adrian Reilly on 4/26/21.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import Firebase

class InitialSurvey4ViewController: UIViewController {
    let myFunctions = FunctionsSuper()
    var ref = Database.database().reference()
    
    @IBOutlet weak var startBaselineLabel: UILabel!
    @IBOutlet weak var determineLabel: UILabel!
    @IBOutlet weak var notNowButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        startBaselineLabel.text = "Baseline of " + String(startBaseLine) + " kg"
        

    }
    
    
    //offer sign up page
    @IBAction func signUpPressed(_ sender: Any) {
        tookSurvey = true
        let vc = storyboard?.instantiateViewController(withIdentifier: "signUpID") as! UIViewController
        vc.modalPresentationStyle = .fullScreen
            DispatchQueue.main.async {
                self.present(vc, animated: false, completion: nil)
            }
    }
    
    
    //not now clicked goes to homescreen
    @IBAction func notNowAndNotLoggedInPress(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "mainStart") as! UITabBarController
        vc.modalPresentationStyle = .fullScreen
            DispatchQueue.main.async {
                self.present(vc, animated: false, completion: nil)
            }
        
    }
    @IBAction func doneButtonPress(_ sender: Any) {
        //set survey
        self.ref.child(self.myFunctions.getUidValue()).child("surveycheck").setValue(1)
        //set weekly value
        self.ref.child(self.myFunctions.getUidValue()).child("weeklygoal").setValue(startBaseLine)
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "mainStart") as! UITabBarController
        vc.modalPresentationStyle = .fullScreen
            DispatchQueue.main.async {
                self.present(vc, animated: false, completion: nil)
            }
        
    }
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Auth.auth().currentUser !=  nil {
            determineLabel.isHidden = true
            notNowButton.isHidden = true
            signUpButton.isHidden = true
            doneButton.isHidden = false
            
        } else {
            determineLabel.isHidden = false
            notNowButton.isHidden = false
            signUpButton.isHidden = false
            doneButton.isHidden = true
            
        }
    }
    
}
