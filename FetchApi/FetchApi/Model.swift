//
//  Model.swift
//  FetchApi
//
//  Created by Dwiki Dwiki on 17/08/23.
//

import Foundation


struct Product: Codable {
    let id: Int
    let title: String
    let description: String
    let price: Double
    let discountPercentage: Double
    let rating: Double
    let stock: Int
    let brand: String
    let category: String
    let thumbnail: String
    let images: [String]
}


struct ProductListResponse: Codable {
    let products: [Product]
    let total: Int
    let skip: Int
    let limit: Int
}
