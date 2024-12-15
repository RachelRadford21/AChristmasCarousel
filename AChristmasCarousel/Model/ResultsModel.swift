//
//  ResultsModel.swift
//  AChristmasCarousel
//
//  Created by Rachel Radford on 12/17/23.
//

import Foundation
import SwiftData

@Model
class Results: Codable {
    var total: Int?
    var imageDescription: String?
    let results: [Images]

    enum CodingKeys: String, CodingKey {
        case imageDescription, results, total
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.total = try? container.decode(Int.self, forKey: .total)
        self.imageDescription = try? container.decode(String.self, forKey: .imageDescription)
        self.results = try container.decode([Images].self, forKey: .results)
       
    }
    init(total: Int,imageDescription: String, results: [Images]) {
        self.total = total
        self.imageDescription = imageDescription
        self.results = results
    }
    
    func encode(to encoder: Encoder) throws {}
}
