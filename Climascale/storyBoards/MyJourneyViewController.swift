//
//  MyJourneyViewController.swift
//  Climascale
//
//  Created by Adrian Reilly on 4/20/21.
//



import UIKit
import FirebaseFirestore
import FirebaseAuth
import Firebase

//let n = 1234567.0123  let formatter = NumberFormatter() formatter.numberStyle = .decimal  if let s = formatter.string(from: NSNumber(value:n)) {      print ("Here's your number with commas: \(s)") }

//public var journeyLogs = [Double]()

class MyJourneyViewController: UIViewController {
    let myFunctions = FunctionsSuper()
    
    var postData = [Double]()
    var dayLogsArray = [String]()
    var dateLogsArray = [String]()
    
    var ref: DatabaseReference?
    var databaseHandle: DatabaseHandle?
    
    var ref2 = Database.database().reference()
    
    let notLoggedInString = "No saved Journeys please sign up or login to see past Journeys"
    var loggedInCheck = false
    
   
    
    @IBOutlet var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        
        if Auth.auth().currentUser != nil {
            //checkwipe and get rid of 0 0 0 if need
            self.ref2.child(self.myFunctions.getUidValue()).child("checkwipe").getData { (error, snapshot) in
                if let error = error {
                    print("Error getting data \(error)")
                }
                else if snapshot.exists() {
                    let checkWipe = snapshot.value! as? Int ?? 3
                    if self.postData.count > 0 && checkWipe == 0 {
                        //first log wipe
                        self.ref2.child(self.myFunctions.getUidValue()).child("journeylogs").child("firstlog").setValue(nil)
                        //first day wipe
                        self.ref2.child(self.myFunctions.getUidValue()).child("daylogs").child("firstday").setValue(nil)
                        //first date wipe
                        self.ref2.child(self.myFunctions.getUidValue()).child("datelogs").child("firstdate").setValue(nil)
                        //change check wipe to 1
                        self.ref2.child(self.myFunctions.getUidValue()).child("checkwipe").setValue(1)
                    }
                }
                else {
                    print("No data available")
                }
            }
            loggedInCheck = true
            ref = Database.database().reference()
            databaseHandle = ref?.child(myFunctions.getUidValue()).child("datelogs").observe(.childAdded, with: { (snapshot) in
                let post = snapshot.value as? String
                
                if let actualPost = post {
                    self.dateLogsArray.append(actualPost)
                    self.tableView.reloadData()
                }
                else {
                    print("Could not find Data")
                }
                
            })
            ref = Database.database().reference()
            databaseHandle = ref?.child(myFunctions.getUidValue()).child("daylogs").observe(.childAdded, with: { (snapshot) in
                let post = snapshot.value as? String
                
                if let actualPost = post {
                    self.dayLogsArray.append(actualPost)
                    self.tableView.reloadData()
                }
                else {
                    print("Could not find Data")
                }
                
            })
            ref = Database.database().reference()
            databaseHandle = ref?.child(myFunctions.getUidValue()).child("journeylogs").observe(.childAdded, with: { (snapshot) in
                let post = snapshot.value as? Double
                
                if let actualPost = post {
                    self.postData.append(actualPost)
                    self.tableView.reloadData()
                }
                else {
                    print("Could not find Data")
                }
                
            })
            
            
    
            
        } else {
            loggedInCheck = false
        }
        
       

    }
    
    //view did appear get new values
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }

    
    


}

extension MyJourneyViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if loggedInCheck {
            return postData.count
        } else {
            return 1
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if loggedInCheck {
            cell.textLabel?.text = String(postData.reversed()[indexPath.row]) + " " + dayLogsArray.reversed()[indexPath.row ] + " " + dateLogsArray.reversed()[indexPath.row]
            return cell
            
        } else {
            cell.textLabel?.text = notLoggedInString
            return cell
        }
        
    }
    
    
}

