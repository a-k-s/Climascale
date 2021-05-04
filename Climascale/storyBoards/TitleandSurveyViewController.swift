//
//  TitleandSurveyViewController.swift
//  Climascale
//
//  Created by Adrian Reilly on 4/26/21.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import Firebase

class TitleandSurveyViewController: UIViewController {
    
    @IBOutlet weak var loginTitleButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if Auth.auth().currentUser != nil {
            self.loginTitleButton.isHidden = true
            
        }
        

      
    }
    
    @IBAction func startPress(_ sender: Any) {
        if Auth.auth().currentUser != nil {
            let vc = storyboard?.instantiateViewController(withIdentifier: "mainStart") as! UITabBarController
            vc.modalPresentationStyle = .fullScreen
                DispatchQueue.main.async {
                    vc.modalTransitionStyle = .flipHorizontal
                    self.present(vc, animated: true, completion: nil)
                }
            
        } else {
            let vc = storyboard?.instantiateViewController(withIdentifier: "startSurvey") as! UINavigationController
            vc.modalPresentationStyle = .fullScreen
                DispatchQueue.main.async {
                    self.present(vc, animated: true, completion: nil)
                }
        }
        
    
        
    }
    
    
    @IBAction func loginButtonPress(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "loginViewControllerID2") as! UINavigationController
        //vc.modalPresentationStyle = .fullScreen
            DispatchQueue.main.async {
                self.present(vc, animated: false, completion: nil)
            }
        
    }
    


}
