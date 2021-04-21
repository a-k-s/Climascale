//
//  profileViewController.swift
//  Climascale
//
//  Created by Adrian Reilly on 4/19/21.
//

import UIKit
import Firebase

class profileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Auth.auth().currentUser != nil {
            print("signed in")
        }
        else {
            print("not signed in")
            performSegue(withIdentifier: "testingSignup", sender: nil)
        }
    }
    
    @IBAction func logOut(_ sender: Any) {
       do { try Auth.auth().signOut() }
        catch { print("already logged out") }
    }
    

    
   
  
    
    

   

}
