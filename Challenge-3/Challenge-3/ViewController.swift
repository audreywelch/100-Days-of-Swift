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

        loadWord()
        
        guessButton.layer.borderWidth = 0.25
        guessButton.layer.borderColor = UIColor.black.cgColor
        
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
    }
    

}

