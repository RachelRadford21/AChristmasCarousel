//
//  ContentView.swift
//  AChristmasCarousel
//
//  Created by Rachel Radford on 12/16/23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var isActive = false
    @AppStorage("isDarkMode") private var isDarkMode = false
    @Query var results: [Results] = []
    @Environment(\.modelContext) private var modelContext
    var body: some View {
        ZStack {
            isDarkMode ?
            Color.xmasRed.ignoresSafeArea() :
            Color.xmasGreen.ignoresSafeArea()
            VStack {
                if self.isActive {
                    ChristmasImageView()
                } else {
                    VStack {
                        Image("Christmas Carousel")
                            .resizable()
                            .scaledToFit()
                    }
                }
            }
        }.onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                withAnimation {
                    self.isActive = true
                }
            }
        }.task {
            if results.isEmpty || modelContext.hasChanges {
                await fetchImages()
            }
        }
    }
}

extension ContentView {
    func fetchImages() async {
        guard let url = URL(string: "https://api.unsplash.com/search/photos?per_page=30&query=christmas") else { return }
        let token = "YOUR-API-KEY-HERE"
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Client-ID \(token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            do {
                let response = try JSONDecoder().decode(Results.self, from: data)
                DispatchQueue.main.async {
                        modelContext.insert(response)
                }
            } catch {
                print("Error: \(error)")
            }
        }
        task.resume()
    }
}

//
//#Preview {
//    ContentView()
//}

