//
//  ImageViewModel.swift
//  AChristmasCarousel
//
//  Created by Rachel Radford on 12/15/24.
//

import Foundation
import SwiftData

@MainActor @Observable
class ImageViewModel {
    let context: ModelContext
   
    init(
        context: ModelContext? = nil
    ) {
        if let providedContext = context {
            self.context = providedContext
        } else {
            let container = try! ModelContainer(for: Results.self)
            self.context = ModelContext(container)
        }
    }
    
    func fetchImages() async {
        guard let url = URL(string: "https://api.unsplash.com/search/photos?per_page=30&query=christmas-background") else { return }
        let token = "YOUR-API-KEY"
    
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Client-ID \(token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            do {
                let response = try JSONDecoder().decode(Results.self, from: data)
                DispatchQueue.main.async {
                    
                    self.context.insert(response)
                }
            } catch {
                print("Error: \(error)")
            }
        }
        task.resume()
    }
}
