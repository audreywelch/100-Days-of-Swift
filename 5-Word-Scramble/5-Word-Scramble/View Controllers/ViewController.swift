//
//  ViewController.swift
//  5-Word-Scramble
//
//  Created by Audrey Welch on 9/26/19.
//  Copyright © 2019 Audrey Welch. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    // MARK: - Properties
    
    var allWords: [String] = []
    var usedWords: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Find the file path
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            // Load file into a string
            if let startWords = try? String(contentsOf: startWordsURL) {
                // Split string into an array of strings based on the line breaks
                allWords = startWords.components(separatedBy: "\n")
            }
        }
        if allWords.isEmpty {
            allWords = ["silkworm"]
        }
        
        startGame()
    }
    
    // MARK: - Table View Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WordCell", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }

    func startGame() {
        self.title = allWords.randomElement()
        usedWords.removeAll(keepingCapacity: true)
        self.tableView.reloadData()
    }

}

