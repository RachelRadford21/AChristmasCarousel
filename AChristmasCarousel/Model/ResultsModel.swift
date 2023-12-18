//
//  ResultsModel.swift
//  AChristmasCarousel
//
//  Created by Rachel Radford on 12/17/23.
//

import Foundation
import SwiftData

//struct Results: Codable {
//    var total: Int
//    let results: [Images]
//}

@Model
class Results: Codable {
    var total: Int?
    let results: [Images]
    
enum CodingKeys: String, CodingKey {
    case total, results
}
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.total = try container.decode(Int.self, forKey: .total)
        self.results = try container.decode([Images].self, forKey: .results)
    }
    init(total: Int, results: [Images]) {
        self.total = total
        self.results = results
    }
    
    func encode(to encoder: Encoder) throws {
        // Toddo: handle encoding here if you need to
    }
}
