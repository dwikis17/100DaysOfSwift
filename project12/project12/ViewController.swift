//
//  ViewController.swift
//  project12
//
//  Created by Dwiki Dwiki on 23/09/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
        let defaults = UserDefaults.standard
        
        defaults.set(25, forKey: "Age")
        defaults.set(true, forKey: "UseFaceID")
        defaults.set(CGFloat.pi, forKey: "pi")
        
        let savedInteger = defaults.integer(forKey: "Age")
    }


}

