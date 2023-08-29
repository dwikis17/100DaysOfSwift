//
//  TableViewController.swift
//  Project4
//
//  Created by Dwiki Dwiki on 21/08/23.
//

import UIKit

class TableViewController: UITableViewController {
    
    var urls = ["apple.com", "hackingwithswift.com"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return urls.count
    }
  


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "url", for: indexPath)
        
        cell.textLabel?.text = urls[indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "WebView") as? ViewController {
            vc.loadedWeb = urls[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }

}
