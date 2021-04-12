//
//  LeaderboardViewController.swift
//  Climascale
//
//  Created by student on 4/9/21.
//

import UIKit

class LeaderboardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
   @IBOutlet weak var boardTableView: UITableView!
    var profiles : [Profile]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        boardTableView.delegate = self
        boardTableView.dataSource = self
        let profile1 = Profile(name: "Ryan", netCO2Saved: "500")
        let profile2 = Profile(name: "Joshua", netCO2Saved: "200")
        let profile3 = Profile(name: "Abigal", netCO2Saved: "100")
        let profile4 = Profile(name: "Trevor", netCO2Saved: "80")
        let profile5 = Profile(name: "Adrian", netCO2Saved: "40")
        profiles = [profile1, profile2, profile3, profile4, profile5]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profiles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
        let profile = profiles[indexPath.row]
        cell.textLabel?.text = profile.name.capitalized
        cell.detailTextLabel?.text = profile.netCO2Saved

        return cell
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
        
        
        
        
        // Do any additional setup after loading the view.
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


