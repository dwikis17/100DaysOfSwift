//
//  ViewController.swift
//  project4-6-milestone
//
//  Created by Dwiki Dwiki on 28/08/23.
//

import UIKit

class ViewController: UITableViewController {

    var shoppingList = [String]()
    
    func addItem(for newItem: String) {
        if(newItem.isEmpty) {
            return
        }
        shoppingList.insert(newItem, at: 0)
        
        let indexPath = [IndexPath(row: 0, section: 0)]
        tableView.insertRows(at: indexPath, with: .left)
    }
    
    @objc func addNewItem(){
        let ac = UIAlertController(title: "Add New Item", message: nil, preferredStyle: .alert)
        
        
        ac.addTextField()
        let shareAction = UIAlertAction(title: "Share", style: .default) {UIAlertAction in
            let list = self.shoppingList.joined(separator: "\n")
            let act =  UIActivityViewController(activityItems: [list], applicationActivities: [])
            act.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
            self.present(act, animated: true)
        }
        
        ac.addAction(shareAction)
        ac.addAction(UIAlertAction(title: "Add", style: .default, handler: { [weak self, weak ac] _ in
            guard let newItem = ac?.textFields?[0].text else { return }
            self?.addItem(for: newItem)
        }))
        
        present(ac,animated: true)
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Your Shopping List"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action:#selector(addNewItem))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteAllItems))
        
    }
    
    @objc func deleteAllItems(){
        shoppingList.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "list", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        shoppingList.count
    }

}

