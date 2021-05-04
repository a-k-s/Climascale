//
//  InitialSurvey2ViewController.swift
//  Climascale
//
//  Created by Adrian Reilly on 4/26/21.
//

import UIKit

class InitialSurvey2ViewController: UIViewController {
    
    @IBOutlet var averageMilesInput: UITextField!
    
  

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        

    }
    
    @IBAction func nextQuestionCheck(_ sender: Any)  {
        averageMilesSurvey = Double(averageMilesInput.text!) ?? -1
        if averageMilesSurvey == -1 {
            
        } else {
            performSegue(withIdentifier: "checkForNumbersID", sender: nil)
        }
        
        
    }
    
    
    

}






