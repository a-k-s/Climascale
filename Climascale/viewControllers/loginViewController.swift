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

    override func viewDidLoad() {
        super.viewDidLoad()

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
                
            }
            else {
                //login works
                print("login success")
            }
        }
    }

  

}
