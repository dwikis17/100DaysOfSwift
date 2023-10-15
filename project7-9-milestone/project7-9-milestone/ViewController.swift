//
//  ViewController.swift
//  project7-9-milestone
//
//  Created by Dwiki Dwiki on 02/09/23.
//

import UIKit

class ViewController: UIViewController {
    
    var words = [String]()
    var usedWords = [String]() {
        didSet {
            title = displayWord()
        }
    }
    let submitButton = UIButton()
    let textField = UITextField()
    var level = 0 {
        didSet {
            title = displayWord()
        }
    }
    var incorrectGuessCount = 0 {
        didSet {
            incorrectGuessLabel.text = "\(incorrectGuessCount)/5"
            if incorrectGuessCount >  3 {
                incorrectGuessLabel.textColor = .red
            } else {
                incorrectGuessLabel.textColor = .black
            }
            

        }
    }
    var incorrectGuessLabel = UILabel()
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        view.backgroundColor = .systemCyan
        navigationController?.navigationBar.prefersLargeTitles = true
        loadText()
        title = displayWord()
        setupTextField()
        setupButton()
        setupGuessLabel()
    }

    func displayWord() -> String {
        let word = words[level]
        var promptWords = ""
        
        for letter in word {
            let strLetter = String(letter)
            
            if usedWords.contains(strLetter) {
                promptWords += strLetter
            } else {
                promptWords += "?"
            }
        }
        
        return promptWords
        
    }

    
    func loadText() {
        if let startWordUrl = Bundle.main.url(forResource: "project9files", withExtension: ".txt") {
            if let startWord = try? String(contentsOf: startWordUrl) {
                words = startWord.components(separatedBy: "\n")
//               words.shuffle()
            }
        }
        
    }
    
    
    func setupGuessLabel() {
        view.addSubview(incorrectGuessLabel)
        incorrectGuessLabel.translatesAutoresizingMaskIntoConstraints = false
        incorrectGuessLabel.text = "\(incorrectGuessCount)/5"
        
        incorrectGuessLabel.font = .systemFont(ofSize: 34)
        NSLayoutConstraint.activate([
            incorrectGuessLabel.topAnchor.constraint(equalTo: submitButton.bottomAnchor, constant: 25),
            incorrectGuessLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    enum ErrorType {
        case invalidLetterCount, incorrectGuess
    }
    
    func setupButton() {
  
        view.addSubview(submitButton)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.configuration = .filled()
        submitButton.configuration?.baseBackgroundColor = .systemPink
        submitButton.setTitle("Submit", for: .normal)
        
        NSLayoutConstraint.activate([
            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            submitButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 30),
        ])
        
        submitButton.addTarget(self, action: #selector(submit), for: .touchUpInside)
    }
    
    @objc func submit() {
        if let submittedGuess = textField.text {
            if submittedGuess.count == 1 {
                if words[level].contains(submittedGuess.lowercased()) && !usedWords.contains(submittedGuess.lowercased()) {
                    usedWords.append(submittedGuess.lowercased())
                    textField.text = ""
                    if let titleText = title {
                        if !titleText.contains("?") && level < 5{
                           level += 1
                            usedWords.removeAll()
                        }
                        
                        if level >  5 {
                            let ac = UIAlertController(title: "Well done", message: "you finished all level, start over ?", preferredStyle: .alert)
                            
                            ac.addAction(UIAlertAction(title: "continue", style: .default))
                            
                            present(ac, animated: true)
                        }
                    }
                } else {
                    incorrectGuessCount += 1
                    textField.text = ""
                    showError(type: .incorrectGuess)
                }
            } else {
                showError(type: .invalidLetterCount)
            }
        }
    }
    
    func showError(type: ErrorType) {
        var title = ""
        var message = ""
        
        switch type {
        case .incorrectGuess:
            message = "Letter is not found in the word, try again !"
            title = "WRONG !"
            
        case .invalidLetterCount:
            title =  "Error"
            message = " You can only input 1 letter"
        }
        
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "continue", style: .default))
        textField.text = ""
        present(ac, animated: true)
    }
    
    func setupTextField() {
        view.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "enter your guess here"
        textField.borderStyle = .roundedRect
      
        NSLayoutConstraint.activate([
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                  textField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                  textField.widthAnchor.constraint(equalToConstant: 200),
           
        ])
    }
}

