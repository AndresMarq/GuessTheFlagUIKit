//
//  ViewController.swift
//  GuessTheFlagUIKit
//
//  Created by Andres Marquez on 2021-09-22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var questionCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion()
    }
    
    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        questionCount += 1
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = "\(countries[correctAnswer].uppercased()) \(score)"
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        let message: String
        
        if sender.tag == correctAnswer {
            title = "Correct!"
            score += 1
            message = "Your score is \(score)"
        } else {
            title = "Wrong"
            score -= 1
            message = "That's the flag of \(countries[sender.tag].uppercased()). Your score is \(score)"
        }
        let ac: UIAlertController
        
        if questionCount < 10 {
            ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        } else {
            questionCount = 0
            ac = UIAlertController(title: "Game Over", message: "Your total score was \(score)", preferredStyle: .alert)
            score = 0
        }
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        present(ac, animated: true)
    }
    
    @objc func shareTapped() {
        let sharedText = "My score in GuessTheFlag was \(score)! Can you do better?"
        let vc = UIActivityViewController(activityItems: [sharedText], applicationActivities: [])
        //Required so it doesnt crash on iPad
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
}
