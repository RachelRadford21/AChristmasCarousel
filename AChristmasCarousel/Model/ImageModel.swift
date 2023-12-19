//
//  ImageModel.swift
//  AChristmasCarousel
//
//  Created by Rachel Radford on 12/16/23.
//

import Foundation
import SwiftData

@Model
class Images: Codable {
    var id: String?
    var urls: URLs
    
    enum CodingKeys: String, CodingKey {
        case id, urls
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try? container.decode(String.self, forKey: .id)
        self.urls = try container.decode(URLs.self, forKey: .urls)
    }
    init(id: String, urls: URLs) {
        self.id = id
        self.urls = urls
    }
    func encode(to encoder: Encoder) throws {
        // Toddo: handle encoding here if you need to
    }
}


