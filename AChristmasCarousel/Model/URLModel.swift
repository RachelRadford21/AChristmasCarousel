//
//  URLModel.swift
//  AChristmasCarousel
//
//  Created by Rachel Radford on 12/17/23.
//

import Foundation
import SwiftData

//struct URLs: Codable {
//    var small: String
//}

@Model
class URLs: Codable {
    var small: String
    
    enum CodingKeys: String, CodingKey {
        case small
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.small = try container.decode(String.self, forKey: .small)
        
    }
    func encode(to encoder: Encoder) throws {
        // Toddo: handle encoding here if you need to
    }
}
