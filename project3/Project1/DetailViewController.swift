//
//  DetailViewController.swift
//  Project1
//
//  Created by Dwiki Dwiki on 16/08/23.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    
    var imageName: String?
    var picturePosition: Int?
    var totalPictures: Int?

    @objc func shareTapped() {
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
               print("No image found")
               return
           }

           let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
           vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
           present(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Picture \(picturePosition! + 1) of \(totalPictures!)"
        navigationItem.largeTitleDisplayMode = .never
        if let imageToLoad = imageName {
            imageView.image = UIImage(named: imageToLoad)
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.hidesBarsOnTap = false
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
