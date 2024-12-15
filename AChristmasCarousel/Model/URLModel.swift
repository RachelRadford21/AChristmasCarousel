//
//  URLModel.swift
//  AChristmasCarousel
//
//  Created by Rachel Radford on 12/17/23.
//

import Foundation
import SwiftData


@Model
class URLs: Codable {
    let raw: String
    let full: String
    let regular: String
    let small: String
    enum CodingKeys: String, CodingKey {
        case raw, full, regular, small, thumb
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.raw = try container.decode(String.self, forKey: .raw)
        self.full = try container.decode(String.self, forKey: .full)
        self.regular = try container.decode(String.self, forKey: .regular)
        self.small = try container.decode(String.self, forKey: .small)
        
    }
    init(raw: String, full: String, regular: String, small: String) {
        self.raw = raw
        self.full = full
        self.regular = regular
        self.small = small
    }
    func encode(to encoder: Encoder) throws {}
}
