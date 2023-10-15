//
//  ViewController.swift
//  Project1
//
//  Created by Dwiki Dwiki on 15/08/23.
//

import UIKit

class ViewController: UITableViewController {

    var pictures = [String]()
   
    var pictDictionary = [String: Int]()
    
    @IBOutlet var tableCell: UITableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        performSelector(inBackground: #selector(loadIMageFromBundle), with: nil)
        tableView.reloadData()
      
    }
    
    
    @objc func loadIMageFromBundle() {
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl"){
                pictures.append(item)
                pictDictionary[item] = 0
            }
        }
        
        pictures.sort()
    }
    
    func save() {
        let jsonEncoder = JSONEncoder()
        if let savedData = try? jsonEncoder.encode(pictDictionary),
            let savedPictures = try? jsonEncoder.encode(pictures) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "pictDictionary")
            defaults.set(savedPictures, forKey: "pictures")
        } else {
            print("Failed to save data.")
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        
    
        cell.textLabel?.text = pictures[indexPath.row]
        cell.detailTextLabel?.text = "Viewed \(pictDictionary[pictures[indexPath.row]]) times"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.imageName = pictures[indexPath.row]
            vc.picturePosition = indexPath.row
            vc.totalPictures = pictures.count
            
            navigationController?.pushViewController(vc, animated: true)
        }
        let picture = pictures[indexPath.row]
        pictDictionary[picture]! += 1
        save()
        print(pictDictionary[picture]!)
        tableView.reloadData()
    }

}

