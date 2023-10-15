//
//  ViewController.swift
//  project2
//
//  Created by Dwiki Dwiki on 16/08/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var scoreCount = 0
    var highScore = 0
    
    var correctAnswer = 1
    
    var contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
    
    var questionAsked = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
      
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1

        button1.configuration!.contentInsets = contentInsets
        button2.configuration!.contentInsets = contentInsets
        button3.configuration!.contentInsets = contentInsets
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion()
        
        highScore = loadHighScore()
        print(highScore)
        
    }
    
    func loadHighScore() -> Int {
        let defaults = UserDefaults.standard
        if let savedData = defaults.object(forKey: "highScore") as? Data {
            let jsonDecoder = JSONDecoder()
            if let loadedHighScore = try? jsonDecoder.decode(Int.self, from: savedData) {
                return loadedHighScore
            }
        }
        return 0 // Return nil if there is no saved highScore or if decoding fails.
    }
    
    func save() {
        let jsonEncoder = JSONEncoder()
        if let savedData = try? jsonEncoder.encode(scoreCount){
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "highScore")
        } else {
            print("Failed to save data.")
        }
    }

    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = "\(countries[correctAnswer].uppercased()) score : \(scoreCount)"
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        var message : String
     
    
        if (correctAnswer == sender.tag) {
            scoreCount += 10
            title = "Correct"
            message = "Your score is \(scoreCount)"
           
        } else {
            scoreCount -= 5
            title = "Wrong"
            message = "Wrong ! that's the flag of \(countries[sender.tag])"
        }
        
        
        if questionAsked == 10 {
            questionAsked = 1
            let ac = UIAlertController(title: "Last question", message: "Your Final score is \(scoreCount)", preferredStyle: .alert)
            
            ac.addAction(UIAlertAction(title: "Continue", style: .destructive, handler: askQuestion) )
            
            if(scoreCount > highScore) {
              
                let highScoreAc = UIAlertController(title: "New High Score", message: "You have new high score of \(scoreCount), previous was \(highScore)", preferredStyle: .alert)
                
                highScoreAc.addAction(UIAlertAction(title: "OK", style: .default, handler: askQuestion))
                present(ac, animated: true)
                save()
            }
          
            present(ac, animated: true)
            scoreCount = 0
        }
        questionAsked += 1
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "Continue", style: .destructive, handler: askQuestion) )
        
        present(ac, animated: true)
    }
}

