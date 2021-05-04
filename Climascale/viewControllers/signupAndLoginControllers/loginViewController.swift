//
//  loginViewController.swift
//  Climascale
//
//  Created by Adrian Reilly on 4/19/21.
//

import UIKit
import FirebaseAuth

class loginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.errorLabel.isHidden = true

    }
    
    @IBAction func unwindToLogin( _ seg: UIStoryboardSegue) {
    }
    
    
    @IBAction func loginTapped(_ sender: Any) {
        //validate text fields
        
        //create cleaned versions of the text field
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        //signing in the user
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
            if error != nil {
                //couldnt sign in
                print("error")
                self.performSegue(withIdentifier: "segueAnyway", sender: nil)
                self.errorLabel.isHidden = false
                
            }
            else {
                //login works
                print("login success")
                self.performSegue(withIdentifier: "segueAnyway", sender: nil)
            }
        }
    }

  

}
