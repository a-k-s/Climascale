//
//  AfterSignUpViewController.swift
//  Climascale
//
//  Created by Adrian Reilly on 4/26/21.
//

import UIKit
import FirebaseAuth
import Firebase

class AfterSignUpViewController: UIViewController {
    
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var continueButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    @IBAction func continueButtonPress(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "mainStart") as! UITabBarController
        vc.modalPresentationStyle = .fullScreen
            DispatchQueue.main.async {
                self.present(vc, animated: true, completion: nil)
            }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Auth.auth().currentUser != nil {
            statusLabel.text = "Sign Up Successful"
            self.continueButton.isHidden = false
        }
        else {
            statusLabel.text = "Sign Up Unsuccessful Please Try Again"
            self.continueButton.isHidden = true
            
        }
    }
    


}
