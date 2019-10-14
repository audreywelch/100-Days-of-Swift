//
//  ViewController.swift
//  7-Whitehouse-Petitions
//
//  Created by Audrey Welch on 10/3/19.
//  Copyright © 2019 Audrey Welch. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var petitions: [Petition] = []
    var filteredPetitions: [Petition] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Whitehouse Petitions"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Credits", style: .plain, target: self, action: #selector(showCredits))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(filterResults))
        

        
        performSelector(inBackground: #selector(fetchJSON), with: nil)
        

//
//            self.showError()
//        }
    }
    
    @objc func fetchJSON() {
        let urlString: String
        
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
            // backup: "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        

        // Make sure the URL is valid
        if let url = URL(string: urlString) {
            // Create a new Data object using its contentsOf method to return the content from the URL
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
                return
            }
        }
        
        performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            filteredPetitions = petitions
            
            // Reload table view on the main thread
            tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
        } else {
            performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
        }
    }
    
    @objc func showError() {

        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(ac, animated: true)
    }
    
    
    @objc func showCredits() {
        
        let ac = UIAlertController(title: "Credits", message: "The information in this application is provided by the We The People API of the Whitehouse.", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .cancel)
        
        ac.addAction(action)
        present(ac, animated: true)
    }
    
    @objc func filterResults() {
        
        let ac = UIAlertController(title: "Filter Results", message: "Enter keywords of petitions you'd like to see.", preferredStyle: .alert)
        
        // Add a single text field to the controller
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] _ in
            // Read the value that was inserted into the text field
            guard let keywords = ac?.textFields?[0].text else { return }
            self?.submit(keywords)
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    func submit(_ keywords: String) {
        
        filteredPetitions = []
        
        let lowerKeyword = keywords.lowercased()
        
        for eachPetition in petitions {
            if eachPetition.title.lowercased().contains(lowerKeyword) || eachPetition.body.lowercased().contains(lowerKeyword) {
                filteredPetitions.append(eachPetition)
            }
        }
        
        tableView.reloadData()
        
    }
    

    

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPetitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let petition = filteredPetitions[indexPath.row]
        
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        
        return cell
    }
    
    // Load the DetailViewController class directly
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = filteredPetitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }


}

