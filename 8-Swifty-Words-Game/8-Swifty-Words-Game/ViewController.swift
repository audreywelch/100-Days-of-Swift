//
//  ViewController.swift
//  8-Swifty-Words-Game
//
//  Created by Audrey Welch on 10/8/19.
//  Copyright © 2019 Audrey Welch. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var cluesLabel: UILabel!
    var answersLabel: UILabel!
    var currentAnswer: UITextField!
    var scoreLabel: UILabel!
    var letterButtons = [UIButton]()
    var activatedButtons = [UIButton]()
    var solutions = [String]()
    
    var score = 0
    var level = 1
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        // VIEW CREATION
        
        scoreLabel = UILabel()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.textAlignment = .right
        scoreLabel.text = "Score: 0"
        view.addSubview(scoreLabel)
        
        cluesLabel = UILabel()
        cluesLabel.translatesAutoresizingMaskIntoConstraints = false
        cluesLabel.font = UIFont.systemFont(ofSize: 24)
        cluesLabel.text = "CLUES"
        cluesLabel.numberOfLines = 0
        view.addSubview(cluesLabel)
        
        answersLabel = UILabel()
        answersLabel.translatesAutoresizingMaskIntoConstraints = false
        answersLabel.font = UIFont.systemFont(ofSize: 24)
        answersLabel.text = "ANSWERS"
        answersLabel.numberOfLines = 0
        answersLabel.textAlignment = .right
        view.addSubview(answersLabel)
        
        cluesLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        answersLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        
        currentAnswer = UITextField()
        currentAnswer.translatesAutoresizingMaskIntoConstraints = false
        currentAnswer.placeholder = "Tap letters to guess"
        currentAnswer.textAlignment = .center
        currentAnswer.font = UIFont.systemFont(ofSize: 44)
        currentAnswer.isUserInteractionEnabled = false
        view.addSubview(currentAnswer)
        
        let submit = UIButton(type: .system)
        submit.translatesAutoresizingMaskIntoConstraints = false
        submit.setTitle("SUBMIT", for: .normal)
        view.addSubview(submit)
        submit.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        
        let clear = UIButton(type: .system)
        clear.translatesAutoresizingMaskIntoConstraints = false
        clear.setTitle("CLEAR", for: .normal)
        view.addSubview(clear)
        clear.addTarget(self, action: #selector(clearTapped), for: .touchUpInside)
        
        let buttonsView = UIView()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonsView)
        
        // AUTOLAYOUT
        
        NSLayoutConstraint.activate([
            
            // Pin the label so that there is a little distance from right edge of screen
            scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            
            // Pin the top of the clues label to the bottom of the score label
            cluesLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
            
            // Pin the leading edge of the clues label to the leading edge of our layout margins, adding 100 for some space
            cluesLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 100),
            
            // Make the clues label 60% of the width of our layout margins, minus 100
            cluesLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.6, constant: -100),
            
            // Also pin the top of the answers label to the bottom of the score label
            answersLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
            
            // Make the answers label stick to the trailing edge of our layout margins, minus 100
            answersLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -100),
            
            // Make the answers label take up 40% of the available space, minus 100
            answersLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.4, constant: -100),
            
            // Make the answers label match the height of the clues label
            answersLabel.heightAnchor.constraint(equalTo: cluesLabel.heightAnchor),
            
            // Pin the text field so it's centered, 50% of the width, and below the clues label with 20 points of spacing
            currentAnswer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            currentAnswer.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            currentAnswer.topAnchor.constraint(equalTo: cluesLabel.bottomAnchor, constant: 20),
            
            // Set vertical positions of buttons to use bottom of answer text field
            // Center buttons horizontally in main view, making sure they are not overlapping
            // Height of buttons is 44
            submit.topAnchor.constraint(equalTo: currentAnswer.bottomAnchor),
            submit.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -100),
            submit.heightAnchor.constraint(equalToConstant: 44),
            
            clear.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 100),
            clear.centerYAnchor.constraint(equalTo: submit.centerYAnchor),
            clear.heightAnchor.constraint(equalToConstant: 44),
            
            // Buttons view has width and height of 750x320 so that it precisely contains the buttons inside
            buttonsView.widthAnchor.constraint(equalToConstant: 750),
            buttonsView.heightAnchor.constraint(equalToConstant: 320),
            
            // Center buttons view horizontally
            buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // Set buttons view top anchor to be the bottom of the submit button, plus 20 points to add extra spacing
            buttonsView.topAnchor.constraint(equalTo: submit.bottomAnchor, constant: 20),
            
            // Pin buttons view to the bottom of layout margins, -20 so that it doesn't run quite to the edge
            buttonsView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20)
        ])
        
        // Set values for the width and height of each button
        let width = 150
        let height = 80
        
        // Create 20 buttons as a 4x5 grid
        for row in 0..<4 {
            for col in 0..<5 {
                
                // Create a new button and give it a big font size
                let letterButton = UIButton(type: .system)
                letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 36)
                
                // Give the button temporary text in order to see it on-screen
                letterButton.setTitle("WWW", for: .normal)
                
                // Calculate the frame of this button using its column and row
                let frame = CGRect(x: col * width, y: row * height, width: width, height: height)
                letterButton.frame = frame
                
                // Add it to the buttons view
                buttonsView.addSubview(letterButton)
                
                // And also to our letterButtons array
                letterButtons.append(letterButton)
                
                // All letter buttons call the letterTapped() function when tapped
                letterButton.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadLevel()
    }
    
    @objc func letterTapped(_ sender: UIButton) {
        
        // Safety check to read the title from the tapped button
        guard let buttonTitle = sender.titleLabel?.text else { return }
        
        // Append that button title to the player's current answer
        currentAnswer.text = currentAnswer.text?.appending(buttonTitle)
        
        // Append the button to the activatedButtons array
        activatedButtons.append(sender)
        
        // Hide the button that was tapped
        sender.isHidden = true
    }
    
    @objc func submitTapped(_ sender: UIButton) {
        
        guard let answerText = currentAnswer.text else { return }
        
        // Search through solutions array for an item, and if it finds it, tell us its position
        if let solutionPosition = solutions.firstIndex(of: answerText) {
            activatedButtons.removeAll()
            
            // Split the answer label text up by \n
            var splitAnswers = answersLabel.text?.components(separatedBy: "\n")
            // Replace the line at the solution position with the solution itself
            splitAnswers?[solutionPosition] = answerText
            // Re-join the answers label back together
            answersLabel.text = splitAnswers?.joined(separator: "\n")
            
            // Clear the current answer text field
            currentAnswer.text = ""
            // Add one to the score
            score += 1
            
            // If the user has found all seven words, present alert controller to prompt them to go to next level
            if score % 7 == 0 {
                let ac = UIAlertController(title: "Well done!", message: "Are you ready for the next level?", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Let's go!", style: .default, handler: levelUp))
                present(ac, animated: true)
            }
        }
    }
    
    @objc func clearTapped(_ sender: UIButton) {
        
        // Remove text from the current asnwer field
        currentAnswer.text = ""
        
        // Unhide all the activated buttons
        for btn in activatedButtons {
            btn.isHidden = false
        }
        
        // Remove all the items from the activated buttons array
        activatedButtons.removeAll()
    }
    
    func loadLevel() {
        var clueString = ""
        var solutionString = ""
        var letterBits = [String]()
        
        // Find and load the level string from our app bundle
        if let levelFileURL = Bundle.main.url(forResource: "level\(level)", withExtension: "txt") {
            if let levelContents = try? String(contentsOf: levelFileURL) {
                
                // Split text into an array by breaking on the new line character
                var lines = levelContents.components(separatedBy: "\n")
                // Shuffle array so that the game is a little different each time
                lines.shuffle()
                
                // Go through each item in the lines array, keeping track of where each item was in the array
                // so that we can use it in our clue string
                for (index, line) in lines.enumerated() {
                    
                    // Split each line by the semi colon, which separates the letter groups from its clue
                    let parts = line.components(separatedBy: ": ")
                    let answer = parts[0]
                    let clue = parts[1]
                    
                    clueString += "\(index + 1). \(clue)\n"
                    
                    // Replace | with an empty string so the answers changes from "HA|UNT|ED" to "Haunted"
                    let solutionWord = answer.replacingOccurrences(of: "|", with: "")
                    // Use the count to get the length of string to add to our solution string
                    solutionString += "\(solutionWord.count) letters\n"
                    solutions.append(solutionWord)
                    
                    // Turn "HA|UNT|ED" into an array of three elements and add it to our letterBits array
                    let bits = answer.components(separatedBy: "|")
                    letterBits += bits
                }
            }
        }
        
        // Configure buttons and labels
        
        // Removeswhitespaces and lines from start and end of the string
        cluesLabel.text = clueString.trimmingCharacters(in: .whitespacesAndNewlines)
        answersLabel.text = solutionString.trimmingCharacters(in: .whitespacesAndNewlines)
        
        letterBits.shuffle()
        
        // Set titles of buttons
        if letterBits.count == letterButtons.count {
            for i in 0 ..< letterButtons.count {
                letterButtons[i].setTitle(letterBits[i], for: .normal)
            }
        }
    }
    
    func levelUp(action: UIAlertAction) {
        
        // Add one to level
        level += 1
        
        // Remove all items from the solutions array
        solutions.removeAll(keepingCapacity: true)
        
        // Call loadLevel() so that  new level file is loaded and shown
        loadLevel()
        
        // Make sure all letter buttons are visible
        for btn in letterButtons {
            btn.isHidden = false
        }
    }


}

