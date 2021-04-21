//
//  MyJourneyViewController.swift
//  Climascale
//
//  Created by Adrian Reilly on 4/20/21.
//

import UIKit

public var journeyLogs = [Double]()

class MyJourneyViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

    }
    

 

}

extension MyJourneyViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return journeyLogs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = String(journeyLogs[indexPath.row])
        
        return cell
    }
}
