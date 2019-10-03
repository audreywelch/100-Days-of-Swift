//
//  ViewController.swift
//  7-Whitehouse-Petitions
//
//  Created by Audrey Welch on 10/3/19.
//  Copyright © 2019 Audrey Welch. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var petitions: [Petition] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
        // backup: "https://www.hackingwithswift.com/samples/petitions-1.json"
        
        // Make sure the URL is valid
        if let url = URL(string: urlString) {
            // Create a new Data object using its contentsOf method to return the content from the URL
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
            }
        }
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let petition = petitions[indexPath.row]
        
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        
        return cell
    }


}

