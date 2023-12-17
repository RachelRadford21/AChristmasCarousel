//
//  ImageModel.swift
//  AChristmasCarousel
//
//  Created by Rachel Radford on 12/16/23.
//

import Foundation


struct Results: Codable {
    var total: Int
    let results: [Images]
}

struct Images: Codable {
    var id: String
    var description: String?
    var urls: URLs
}

struct URLs: Codable {
    var small: String
}


