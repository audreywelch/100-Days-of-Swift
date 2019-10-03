//
//  ViewController.swift
//  Challenge-2
//
//  Created by Audrey Welch on 10/2/19.
//  Copyright © 2019 Audrey Welch. All rights reserved.
//

import UIKit

class ShoppingListTableViewController: UITableViewController {
    
    var shoppingList: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Shopping List"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Add right bar button item
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTextField))
        
        // Add left bar button item
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(clearShoppingList))
    }
    
    @objc func addTextField() {
        
        let ac = UIAlertController(title: "Enter Item to Add to List", message: nil, preferredStyle: .alert)
        
        // Add a single text field
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] _ in
            guard let newItem = ac?.textFields?[0].text else { return }
            self?.submit(newItem)
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
        
    }
    
    @objc func clearShoppingList() {
        shoppingList = []
        tableView.reloadData()
    }
    
    func submit(_ newItem: String) {
        shoppingList.insert(newItem, at: 0)
        
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row]
        return cell
    }


}

