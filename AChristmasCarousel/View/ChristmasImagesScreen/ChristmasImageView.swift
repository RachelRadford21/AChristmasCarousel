//
//  ChristmasImageView.swift
//  AChristmasCarousel
//
//  Created by Rachel Radford on 12/16/23.
//

import SwiftUI
import SwiftData

struct ChristmasImageView: View {
    @Query var images: [Images] = []
    @AppStorage("isDarkMode") private var isDarkMode = false
    var body: some View {
        VStack {
            DarkModeView()
            TabView {
                ForEach(images, id: \.self) { image in
                    AsyncImage(url: URL(string: image.urls.regular)) { urlImage in
                        urlImage
                            .resizable()
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .scaleEffect(CGSize(width: 1.0, height: 1.0))
                            .padding(.horizontal, 5)
                    } placeholder: {
                        ProgressView(String("🎄"))
                    }
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
    }
}
