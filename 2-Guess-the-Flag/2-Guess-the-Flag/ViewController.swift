//
//  ViewController.swift
//  2-Guess-the-Flag
//
//  Created by Audrey Welch on 9/16/19.
//  Copyright © 2019 Audrey Welch. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    var countries: [String] = []
    
    // Holds whether flag 0, 1, or 2 holds the correct answer
    var correctAnswer = 0
    
    // Holds the score
    var score = 0
    
    var numberOfQuestionsAsked = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add border
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        // Add border color
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        // Add country names to the array
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        askQuestion()
    }
    
    func askQuestion(action: UIAlertAction! = nil) {
        
        // Shuffle array so that the first 3 flags will always be different
        countries.shuffle()
        
        // Display images of flags on the buttons
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        correctAnswer = Int.random(in: 0...2)
        
        title = countries[correctAnswer].uppercased()
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        
        var title: String
        
        // If the button's tag matches the correct answer, display "Correct"
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
            
        // If the do not match, display the answer
        } else {
            // If the country has only 2 letters, capitalize the entire string
            if countries[sender.tag].count == 2 {
                title = "Wrong. That's the flag of the \(countries[sender.tag].uppercased())."
                
            // Otherwise, only capitalize the first letter in the string
            } else {
                title = "Wrong. That's the flag of \(countries[sender.tag].capitalizingFirstLetter())."
                score -= 1
            }
            
        }
        
        // Add alert for the user's answer and the score
        if numberOfQuestionsAsked < 10 {
            let ac = UIAlertController(title: title, message: "Your score is \(score).", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            present(ac, animated: true)
            
        } else if numberOfQuestionsAsked == 10 {
            let defaults = UserDefaults.standard
            
            if score > defaults.integer(forKey: "HighScore") {
                let ac = UIAlertController(title: "Game Complete", message: "CONGRATULATIONS! You beat your highest score of \(defaults.integer(forKey: "HighScore")). Final Score: \(score).", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Play again!", style: .default, handler: askQuestion))
                present(ac, animated: true)
                
                save()
                
                score = 0
                numberOfQuestionsAsked = 0
            } else {
                let ac = UIAlertController(title: "Game Complete", message: "Final Score: \(score)", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Play again!", style: .default, handler: askQuestion))
                present(ac, animated: true)
                
                save()
                
                score = 0
                numberOfQuestionsAsked = 0
            }
            
            
        }
        
        numberOfQuestionsAsked += 1
        
    }
    
    func save() {
        
        let defaults = UserDefaults.standard
        
        if score > defaults.integer(forKey: "HighScore") {
            defaults.set(score, forKey: "HighScore")
        }
        
    }
    

}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

