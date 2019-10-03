//
//  ViewController.swift
//  7-Whitehouse-Petitions
//
//  Created by Audrey Welch on 10/3/19.
//  Copyright © 2019 Audrey Welch. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var petitions: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = "Title goes here"
        cell.detailTextLabel?.text = "Subtitle goes here"
        
        return cell
    }


}

