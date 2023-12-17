//
//  ViewModel.swift
//  AChristmasCarousel
//
//  Created by Rachel Radford on 12/16/23.
//

import Foundation

@MainActor
class ViewModel: ObservableObject {
    @Published var results = [Images]()
    @Published var imageString: String?
    @Published var imageID: String?
    @Published var pageNum: Int?
    
    func fetchImages() async {
        guard let url = URL(string: "https://api.unsplash.com/search/photos?per_page=50&query=christmas") else { return }
        let token = "YOUR-API-KEY-HERE"
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Client-ID \(token)", forHTTPHeaderField: "Authorization")
        
        let _: Void = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            do {
                let response = try JSONDecoder().decode(Results.self, from: data)
                DispatchQueue.main.async {
                    self.results.append(contentsOf: response.results)
                    print("Results: \(String(describing: self.results))")
                }
            } catch {
                print("Error: \(error)")
            }
        }
        .resume()
    }
}
