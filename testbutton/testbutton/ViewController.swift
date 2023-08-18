//
//  ViewController.swift
//  testbutton
//
//  Created by Dwiki Dwiki on 16/08/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var buton1: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buton1.layer.borderWidth = 1
        
        buton1.configuration!.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
    }


}

