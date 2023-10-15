//
//  DetailViewController.swift
//  project10-12-milestone
//
//  Created by Dwiki Dwiki on 15/10/23.
//

import UIKit

class DetailViewController: UIViewController {

    var imagePath: String?
    var caption: String?
    
    var myImage:UIImageView = {
        var iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    
    func setupUI() {
        self.view.addSubview(myImage)

        self.myImage.image = UIImage(contentsOfFile: imagePath!)
        NSLayoutConstraint.activate([
            myImage.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            myImage.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            myImage.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            myImage.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title  = caption
        setupUI()
    }
    

}
