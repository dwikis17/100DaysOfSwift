//
//  ViewController.swift
//  Project1
//
//  Created by Dwiki Dwiki on 15/08/23.
//

import UIKit

class ViewController: UICollectionViewController {

    var pictures = [Image]()
   
    @IBOutlet var tableCell: UITableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        performSelector(inBackground: #selector(loadIMageFromBundle), with: nil)
        collectionView.reloadData()
      
    }
    
    
    @objc func loadIMageFromBundle() {
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)

        for item in items {
            if item.hasPrefix("nssl"){
                let picture = Image(image: item, imageName: item)
                pictures.append(picture)
            }
        }
        
       print(pictures)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Image", for: indexPath) as? ImageCellCollectionViewCell else {
            fatalError("unable to find imagecell")
        }
        
        let image = pictures[indexPath.item]
        
        cell.imageName.text = image.imageName
        cell.imageView.image = UIImage(named: image.imageName)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(pictures.count)
        return pictures.count
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController else { return }
        let image = pictures[indexPath.item]
        vc.imageName = image.imageName

        vc.picturePosition = indexPath.item
        vc.totalPictures = pictures.count
        navigationController?.pushViewController(vc, animated: true)
        
    }

}

