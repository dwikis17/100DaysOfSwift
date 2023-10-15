//
//  TableViewController.swift
//  project10-12-milestone
//
//  Created by Dwiki Dwiki on 14/10/23.
//

import UIKit

class TableViewController: UITableViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    var pictures = [Picture]()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(PictureCell.self, forCellReuseIdentifier: PictureCell.identifier)
        title = "Fav Pictures"

        
        if let savedPictures = defaults.object(forKey: "pictures") as? Data {
            let jsonDecoder = JSONDecoder()
            
            do {
                pictures = try jsonDecoder.decode([Picture].self, from: savedPictures)
            } catch {
                fatalError("Error to decode")
            }
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNew))
    }
    
    func save() {
        let jsonEncoder = JSONEncoder()
        if let savedData = try? jsonEncoder.encode(pictures) {
            defaults.set(savedData, forKey: "pictures")
        } else {
            fatalError("Failed to save")
        }
    }
    
    @objc func addNew() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        }
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appending(path: imageName)
        var caption = ""
        
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        let ac = UIAlertController(title: "Add Caption", message: "Write Caption", preferredStyle: .alert)
        
        ac.addTextField()
        
        ac.addAction(UIAlertAction(title: "Add", style: .default, handler: { [weak self] _ in
            guard let name = ac.textFields?[0].text else { return }
            caption = name
      
            let picture = Picture(caption: caption, image: imageName)
            self?.pictures.append(picture)
            self?.save()
            let indexPath = IndexPath(row: (self?.pictures.count ??  1) -  1, section: 0)
            self?.tableView.insertRows(at: [indexPath], with: .fade)
        }))
        dismiss(animated: true)
        present(ac,animated: true)
    
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
  



    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PictureCell.identifier, for: indexPath) as? PictureCell else {
                fatalError("Error")
        }
        let items = self.pictures[indexPath.row]
        let path = getDocumentsDirectory().appending(path: items.image)
        cell.configure(with: path.path, and: items.caption)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        
        let items = pictures[indexPath.row]
        let path = getDocumentsDirectory().appending(path: items.image)
        vc.imagePath = path.path
        vc.caption = items.caption
        
        navigationController?.pushViewController(vc, animated: true)
    }

}

