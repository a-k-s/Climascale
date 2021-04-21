//
//  FunctionsSuper.swift
//  Climascale
//
//  Created by Adrian Reilly on 4/20/21.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import Firebase

class FunctionsSuper {
    
    var ref = Database.database().reference()
    var firstNameValue = ""
    var lastNameValue = ""
    var totalCarbonEmissionsValue = 0.0

    //check if user is currently logged in
    func checkLoggedIn() ->Bool {
        if Auth.auth().currentUser?.uid != nil {
            return true
        } else {
            return false
        }
    }
    
    //retrieve user name from as string
    func getUserFirstName()->String  {
        if checkLoggedIn() {
            let usersUid = Auth.auth().currentUser?.uid ?? ""
            self.ref.child(usersUid).child("firstname").getData { (error, snapshot) in
                if let error = error {
                    print ("error 2")
                }
                else if snapshot.exists() {
                    self.firstNameValue = snapshot.value! as? String ?? ""
                    //print("success")
                }
                else {
                    print ("No data")
                }
            }
            return firstNameValue
        }
        else {
            return ""
        }
    }
    
    func getUserLastName()->String  {
        if checkLoggedIn() {
            let usersUid = Auth.auth().currentUser?.uid ?? ""
            self.ref.child(usersUid).child("lastname").getData { (error, snapshot) in
                if let error = error {
                    print ("error 2")
                }
                else if snapshot.exists() {
                    self.lastNameValue = snapshot.value! as? String ?? ""
                    //print("success")
                }
                else {
                    print ("No data")
                }
            }
            return lastNameValue
        }
        else {
            return ""
        }
    }
    
    
    //get users uid as string
    func getUidValue () -> String {
        if checkLoggedIn() {
            let usersUid = Auth.auth().currentUser?.uid ?? ""
            return usersUid
        }
        else {
            return ""
        }
    }
    //func retrieve total emissions as a float
 
    
    //updates carbon emissions
    func updateCarbonEmissions(sum: Double) {
        //print(getTotalEmissions())
        //if checkLoggedIn() {
            //var oldTotal = getTotalEmissions()
            //print(oldTotal)
           //var newTotal =  oldTotal + sum
            //print(newTotal)
            //self.ref.child(getUidValue()).child("totalcarbonemissions").setValue(newTotal)
        ///}
        
    }
    
    //updates values for confirm page
    //func updateAllValues(carInput: Double) {
        //if checkLoggedIn() {
            //self.ref.child(getUidValue()).child("truck").setValue(carInput)
        //}
    //}
    
    
    
    

    
    
    
    
    
    
}
