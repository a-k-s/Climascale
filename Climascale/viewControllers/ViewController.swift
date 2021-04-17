//
//  ViewController.swift
//  Climascale
//
//  Created by Anton Schuster on 3/17/21.
//

import UIKit



public var myTotalEmmissions = 0.0


class ViewController: UIViewController  {
    
    
    
    
    @IBOutlet weak var totalValue: UILabel!
   
    
    

 
    override func viewDidLoad() {
        super.viewDidLoad()
        animateIt()
       
        
    }
    
    @IBAction func testingPress(_ sender: Any) {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        totalValue.text = String(myTotalEmmissions)
        animateIt()
    
    }
    
    
    
    
    
   

}



