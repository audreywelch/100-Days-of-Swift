//
//  ViewController.swift
//  Challenge-3
//
//  Created by Audrey Welch on 10/24/19.
//  Copyright © 2019 Audrey Welch. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var guessButton: UIButton!
    @IBOutlet weak var incorrectGuessesRemainLabel: UILabel!
    @IBOutlet weak var wordStackView: UIStackView!
    
    var wordToGuess = ""
    var numberOfLetters = 0
    
    var letterLabelsArray = [UILabel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Load words from start.txt file
        loadWord()
        
        // UI for Guess Button
        guessButton.layer.borderWidth = 0.25
        guessButton.layer.borderColor = UIColor.black.cgColor
        
        // Create a label for each letter in the word to be guessed
        for letter in wordToGuess {
            
            // Create a label within a stack view that has a "?"
            let letterLabel = UILabel()
            //letterLabel.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
            letterLabel.font = UIFont(name: "Futura", size: UIFont.labelFontSize)
            
            letterLabel.text = "?"
            letterLabel.textAlignment = .center
            letterLabel.layer.borderWidth = 0.25
            letterLabel.layer.borderColor = UIColor.black.cgColor
            
            letterLabelsArray.append(letterLabel)
            
        }
        
        let stackView = UIStackView(arrangedSubviews: letterLabelsArray)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
        
            //stackView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            
            stackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 40),
            
            stackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -40),
            
            stackView.bottomAnchor.constraint(equalTo: guessButton.topAnchor, constant: -50)
            
        ])
        


    }
    
    func loadWord() {
        
        // Find and load the words from the app bundle
        if let startingWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            
            if let wordContents = try? String(contentsOf: startingWordsURL) {
                
                // Split text into an array by breaking on the new line character
                var lines = wordContents.components(separatedBy: "\n")
                
                // Shuffle array so that the game is a little different each time
                lines.shuffle()
                
                wordToGuess = lines[0]
                numberOfLetters = wordToGuess.count
                

            }
        }
    }
    
    func loadBlanks(word: String) {
        

        
    }

    @IBAction func guessbuttonTapped(_ sender: Any) {
        
        let ac = UIAlertController(title: "Enter a letter to guess", message: nil, preferredStyle: .alert)
        
        // Add a single text field to the controller
        ac.addTextField()
        
        let submitGuess = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] _ in
            
            // Read the value that was inserted into the text field
            guard let guess = ac?.textFields?[0].text else { return }
            
            // Only allow users to guess one letter
            if guess.count > 1 {
                
                // Show error message
                let errorAC = UIAlertController(title: "Invalid Guess", message: "You can only guess one letter at a time. Try again.", preferredStyle: .alert)
                errorAC.addAction(UIAlertAction(title: "OK", style: .default))
                self?.present(errorAC, animated: true)
                
            // Submit the user's guess
            } else {
                self?.submit(userGuess: Character(guess))
            }
        }
        
        ac.addAction(submitGuess)
        present(ac, animated: true)
    }
    
    func submit(userGuess: Character) {
        
    }
    

}

