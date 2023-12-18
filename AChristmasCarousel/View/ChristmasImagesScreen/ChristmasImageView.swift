//
//  ChristmasImageView.swift
//  AChristmasCarousel
//
//  Created by Rachel Radford on 12/16/23.
//

import SwiftUI
import SwiftData

struct ChristmasImageView: View {
    @ObservedObject var vm: GlobalViewModel
    @Query var results: [Results] = []
    @State var images: [Images] = []
    @Environment(\.modelContext) private var modelContext
    
    let columns = [GridItem(.flexible()), GridItem(.flexible()),GridItem(.flexible())]
    var body: some View {
        DarkModeView()
        ScrollView(.horizontal, showsIndicators: false) {
        LazyHGrid(rows: columns) {
            ForEach(images, id: \.id) { image in
                AsyncImage(url: URL(string: image.urls.small)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                } placeholder: {
                    Image("Christmas Carousel")
                }
            }
        }.onAppear {
            Task {
                if images.isEmpty {
                    await self.fetchImages()
                }
            }
        }
    }
    }
}

// For some reason when I moved this extension to a diff file, it shows an error message??
extension ChristmasImageView {
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
                    modelContext.insert(response)
                    images = response.results
                    print("Results: \(String(describing: self.images))")
                }
                
            } catch {
                print("Error: \(error)")
            }
        }
        .resume()
    }
}

#Preview {
    ChristmasImageView(vm: GlobalViewModel())
        .environmentObject(GlobalViewModel())
        .modelContainer(for: Results.self)
}
