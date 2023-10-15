//
//  Picture.swift
//  project10-12-milestone
//
//  Created by Dwiki Dwiki on 15/10/23.
//

import UIKit

class Picture: NSObject, Codable {
    var caption: String
    var image: String
    
    init(caption: String, image: String) {
        self.caption = caption
        self.image = image
    }
}
