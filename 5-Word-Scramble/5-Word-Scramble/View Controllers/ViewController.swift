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
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        
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
        title = allWords.randomElement()
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    @objc func promptForAnswer() {
        
        let ac = UIAlertController(title: "Enter Answer", message: nil, preferredStyle: .alert)
        
        // Add a single text field to the controller
        ac.addTextField()
        
        // Trailing Closure Syntax: Give the UIAlertAction some code to execute when it is tapped, and it wants to know that that code accepts a parameter of type UIAlertAction
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] _ in
            // Read the value that was inserted into the text field
            guard let answer = ac?.textFields?[0].text else { return }
            self?.submit(answer)
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    func submit(_ answer: String) {
        
        let lowerAnswer = answer.lowercased()
        
        if isPossible(word: lowerAnswer) {
            if isOriginal(word: lowerAnswer) {
                if isReal(word: lowerAnswer) {
                    usedWords.insert(answer, at: 0)
                    
                    let indexPath = IndexPath(row: 0, section: 0)
                    tableView.insertRows(at: [indexPath], with: .automatic)
                }
            }
        }
        
    }
    
    // MARK: - Word Check Methods
    
    func isPossible(word: String) -> Bool {
        
        guard var tempWord = title?.lowercased() else { return false }
        
        // If the letter is found in the string, remove the used letter from the tempWord variable
        for letter in word {
            // firstIndex(of:) returns the first position of the substring if it exists
            if let position = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: position)
            } else {
                return false
            }
        }
        
        return true
    }
    
    func isOriginal(word: String) -> Bool {
        return !usedWords.contains(word)
    }
    
    func isReal(word: String) -> Bool {
        
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }

}

