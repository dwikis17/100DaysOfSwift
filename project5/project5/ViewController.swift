//
//  ViewController.swift
//  project5
//
//  Created by Dwiki Dwiki on 21/08/23.
//

import UIKit

class ViewController: UITableViewController {
    
    var allWords = [String]()
    var usedWords = [String]()
    var currentWords:String = ""
    var allEntries = [String]()
    
    func loadInitialTitleAndEntries() -> (loadedTitle: String?, loadedEntries:[String]) {
        let defaults = UserDefaults.standard
        var loadedTitle:String?
        var loadedEntries = [String]()
        if let savedCurrentWord = defaults.object(forKey: "currentWord") as? Data {
            let jsonDecoder = JSONDecoder()
            
            do {
                loadedTitle = try jsonDecoder.decode(String.self, from: savedCurrentWord)
            } catch {
                print("failed to decode")
            }
        }
        
        if let savedEntries = defaults.object(forKey: "entries") as? Data {
            let jsonDecoder = JSONDecoder()
            
            do {
                loadedEntries = try jsonDecoder.decode([String].self, from: savedEntries)
            } catch {
                print("failed to decode")
            }
        }
        return (loadedTitle:loadedTitle, loadedEntries: loadedEntries)
    }
    
    @objc func startGame() {
        let (loadedTitle, loadedEntries) = loadInitialTitleAndEntries()
        if let currentTitle = loadedTitle {
            title = currentTitle
        } else {
            title = allWords.randomElement()
            usedWords.removeAll(keepingCapacity: true)
            save(for: title!, with: "currentWord")
            tableView.reloadData()
        }
    
        if !loadedEntries.isEmpty {
            usedWords = loadedEntries
        }
    }
    
    @objc func newGame() {
        save(for: nil, with: "currentWord")
        saveEntries(data: [String]())
        startGame()
    }
    
    func save(for data:String?, with key:String) {
        let jsonEncoder = JSONEncoder()
        if let savedData = try? jsonEncoder.encode(data) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: key)
        } else {
            print("Failed to save current wordds")
        }
    }
    
    func saveEntries(data:[String]) {
        let jsonEncoder = JSONEncoder()
        if let savedData = try? jsonEncoder.encode(data) {
            let defaults = UserDefaults.standard
            print(savedData)
            defaults.set(savedData, forKey: "entries")
        } else {
            print("Failed to save current wordds")
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }
    
    func showErrorMessage(title: String, message: String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac,animated: true)
    }
    
    func submit(_ answer: String) {
        let loweredAnswer = answer.lowercased()

        
        if isPossible(word: loweredAnswer) {
            if isOriginal(word: loweredAnswer) {
                if isReal(word: loweredAnswer) {
                    if loweredAnswer != title?.lowercased() {
                        usedWords.insert(loweredAnswer, at: 0)
                        
                        let indexPath = IndexPath(row: 0, section: 0)
                        tableView.insertRows(at: [indexPath], with: .automatic)
                        saveEntries(data: usedWords)
                        return
                    } else {
                        showErrorMessage(title: "cannot be starter words", message: "cannot be starter words")
                    }
                } else {
                    showErrorMessage(title: "Not real", message: "You cant just make them  up")
                }
            } else {
                showErrorMessage(title: "Used Words", message: "be more original")
            }
        } else {
            showErrorMessage(title: "Not Possible", message: "choose another word")
        }
        
      
    }
    
    func isPossible(word: String) -> Bool {
        guard var tempWord = title?.lowercased() else { return false }
        
        for letter in word {
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
        let mispelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return mispelledRange.location == NSNotFound && word.count >= 3
    }
    
    @objc func promptForAnswer() {
        let ac = UIAlertController(title: "Enter Answer", message: nil, preferredStyle: .alert)
      
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] action in
            guard let answer = ac?.textFields?[0].text else { return }
            self?.submit(answer)
        }
        
        ac.addTextField()
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        
        if let startWordsUrl = Bundle.main.url(forResource: "start", withExtension: ".txt") {
            if let startWords = try? String(contentsOf: startWordsUrl) {
                allWords = startWords.components(separatedBy: "\n")
            }
        }
        
        if allWords.isEmpty {
            allWords = ["silkworm"]
        }
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "New Game", style: .done, target: self, action: #selector(newGame))
        
        startGame()
    }


}

