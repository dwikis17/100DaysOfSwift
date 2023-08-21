//
//  DetailViewController.swift
//  project1-3-milestone
//
//  Created by Dwiki Dwiki on 18/08/23.
//

import UIKit

class DetailViewController: UIViewController {
    
    var imageName: String?
    
    @IBOutlet var image: UIImageView!
    
    @objc func shareTapped() {
        guard let image = image.image?.jpegData(compressionQuality: 0.8) else {
            print("Error no image found")
            return
        }
        
        let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let imageToLoad = imageName {
            image.image = UIImage(named: imageToLoad)
            image.layer.borderWidth = 1
        }
        
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
