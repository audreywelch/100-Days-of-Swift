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
        
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        } else {
            title = "Wrong"
            score -= 1
        }
        
        // Add alert for the user's answer and the score
        let ac = UIAlertController(title: title, message: "Your score is \(score).", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        present(ac, animated: true)
        
    }
    

}

