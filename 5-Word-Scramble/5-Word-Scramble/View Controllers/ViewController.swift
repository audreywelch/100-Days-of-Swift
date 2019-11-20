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
    var submissions: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .play, target: self, action: #selector(startGame))
        
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

    @objc func startGame() {
//        let defaults = UserDefaults.standard
//
//        if defaults.object(forKey: "Submissions") as? [String] != nil {
//            submissions = defaults.object(forKey: "Submissions") as! [String]
//
//            let currentWord = defaults.object(forKey: "CurrentWord") as? String ?? ""
//        }
        
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
                    usedWords.insert(lowerAnswer, at: 0)
                    
                    // Save answer to user defaults
                    save(lowerAnswer)
                    
                    let indexPath = IndexPath(row: 0, section: 0)
                    tableView.insertRows(at: [indexPath], with: .automatic)
                    
                    return
                } else {
                    showErrorMessage(errorTitle: "Word not recognized", errorMessage: "Make sure to use an actual word. It can't be the same as the starting word, and it needs to be at least 3 letters!")
                }
            } else {
                showErrorMessage(errorTitle: "Word used already", errorMessage: "Be more original!")
            }
        } else {
            guard let title = title?.lowercased() else { return }
            
            showErrorMessage(errorTitle: "Word not possible", errorMessage: "You can't spell that word from \(title).")
        }
    }
    
    func save(_ submittedAnswer: String) {
        
        // Add the submission to the array of previously submitted answers
        submissions.append(submittedAnswer)
        
        // Save the submissions array to User Defaults
        let defaults = UserDefaults.standard
        defaults.set(submissions, forKey: "Submissions")
        defaults.set(title?.lowercased(), forKey: "CurrentWord")
        
    }
    
    func showErrorMessage(errorTitle: String, errorMessage: String) {
        
        let ac = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
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
        
        guard let startWord = title?.lowercased() else { return false }
        
        // Disallow answers shorter than 3 letters
        if word.count < 3 {
            return false
            
        // Disallow answers that are the same as the starting word
        } else if word == startWord {
            return false
            
        // Check for misspellings
        } else {
            
            let checker = UITextChecker()
            let range = NSRange(location: 0, length: word.utf16.count)
            let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
            
            return misspelledRange.location == NSNotFound
        }
    }

}

