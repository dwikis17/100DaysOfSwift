//
//  File.swift
//  Project1
//
//  Created by Dwiki Dwiki on 23/09/23.
//

import Foundation


class ImageModel: Codable {
    var imageName: String
    var picturePosition: Int
    var totalPictures: Int

    init(imageName: String, picturePosition: Int, totalPictures: Int) {
        self.imageName = imageName
        self.picturePosition = picturePosition
        self.totalPictures = totalPictures
    }
}
