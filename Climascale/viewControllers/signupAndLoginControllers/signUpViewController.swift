//
//  signUpViewController.swift
//  Climascale
//
//  Created by Adrian Reilly on 4/19/21.
//

import UIKit
import FirebaseAuth
import Firebase

class signUpViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBOutlet weak var errorLabel: UILabel!
    
    var ref = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.errorLabel.isHidden = true

    }
    
    @IBAction func unwindToSignUp( _ seg: UIStoryboardSegue) {
    }
    
    
    @IBAction func signUpTapped(_ sender: Any) {
        //validate the fields
        let error = validateFields()
        if error != nil
        {
            print("error")
            self.errorLabel.isHidden = false
        }
        else
        {
            //create cleaned versions of the data
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            //create the user
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                
                //check for errors
                if err != nil {
                    //there was an error creating the user
                    self.showError("Error creating user")
                    self.errorLabel.isHidden = false
                }
                else {
                    if tookSurvey {
                        self.ref.child(result!.user.uid).setValue(["firstname": firstName, "lastname": lastName, "totalcarbonemissions": 0, "weeklygoal": startBaseLine, "checkwipe": 0, "surveycheck": 1])
                    } else {
                        self.ref.child(result!.user.uid).setValue(["firstname": firstName, "lastname": lastName, "totalcarbonemissions": 0, "weeklygoal": 0, "checkwipe": 0, "surveycheck": 0])
                    }
                    //user war created successfully,now store the first and last name
                    let db = Firestore.firestore()
                    //add user to databse
                    //set journey log first time
                    self.ref.child(result!.user.uid).child("journeylogs").setValue(["firstlog": 0])
                    //set day first time
                    self.ref.child(result!.user.uid).child("daylogs").setValue(["firstday": "0"])
                    //set date
                    self.ref.child(result!.user.uid).child("datelogs").setValue(["firstdate": "0"])
                    db.collection("users").addDocument(data: ["firstname": firstName, "lastname": lastName, "uid": result!.user.uid]) { (error) in
                        self.performSegue(withIdentifier: "segueSignUp", sender: nil)
                        
                        if error != nil {
                            //show error message
                            self.performSegue(withIdentifier: "segueSignUp", sender: nil)
                            self.showError("User data couldn't be saved")
                            self.errorLabel.isHidden = false
                        }
                    }
                    
                    
                }
                
        }
            
            //transition
            self.transitionToSuccess()
            
        }
        
        
    }
    
    //error function
    func showError(_ message: String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    
    }
    
    //transition to success
    func transitionToSuccess() {
        print("success logging in")
        
    }
    
    
    //check the fields and validate that the data is correct. If everything is correct, this method returns nil. Otherwise, it returns the error message
    func validateFields() -> String? {
        //check that all fields are filled in
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields"
        }
        
        
        return nil
    }
    



}
