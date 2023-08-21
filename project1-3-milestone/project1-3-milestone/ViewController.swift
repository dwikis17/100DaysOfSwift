//
//  ViewController.swift
//  project1-3-milestone
//
//  Created by Dwiki Dwiki on 18/08/23.
//

import UIKit

class ViewController: UITableViewController {
    
    var pictures = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
       
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
     
        for item in items {
            if item.hasSuffix(".png") {
                pictures.append(item)
            }
            
        }
        print(pictures.count)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        return pictures.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PicturePreview", for: indexPath)
        
        cell.imageView?.image = UIImage(named: pictures[indexPath.row])
        cell.textLabel?.text = removeSuffix(pictures[indexPath.row], suffix: "@3x.png")
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let inset: CGFloat = 10.0
        cell.contentView.frame = cell.contentView.frame.inset(by: UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset))
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as?
            DetailViewController {
            vc.imageName = pictures[indexPath.row]
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }

}


func removeSuffix(_ string: String, suffix: String) -> String {
    guard string.hasSuffix(suffix) else {
        return string
    }
    
    let endIndex = string.index(string.endIndex, offsetBy: -suffix.count)
    return String(string[..<endIndex])
}
