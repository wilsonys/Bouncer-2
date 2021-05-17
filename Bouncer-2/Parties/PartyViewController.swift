//
//  PartyViewController.swift
//  Bouncer-2
//
//  Created by Quinn Wilson on 5/14/21.
//

import UIKit

class PartyViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var parties = ["Quinn's Birthday", "Marathon Monday Bash", "Ugly Sweater Party"]
    var dates = ["August 15", "April 19", "December 24"]
    
    var searching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self

    }
    

}

extension PartyViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        parties.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PartyCell", for: indexPath)
        cell.textLabel?.text = parties[indexPath.row]
        cell.detailTextLabel?.text = dates[indexPath.row]
        return cell
    }

}

