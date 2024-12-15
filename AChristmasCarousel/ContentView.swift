//
//  ContentView.swift
//  AChristmasCarousel
//
//  Created by Rachel Radford on 12/16/23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    @Environment(\.modelContext) private var context
    @State private var isActive = false
    @Query var results: [Results] = []
    var imageVM: ImageViewModel = ImageViewModel()
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
            if results.isEmpty || context.hasChanges {
           await imageVM.fetchImages()
               
            }
        }
    }
}

