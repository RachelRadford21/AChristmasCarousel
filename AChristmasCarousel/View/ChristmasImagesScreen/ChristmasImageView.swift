//
//  ChristmasImageView.swift
//  AChristmasCarousel
//
//  Created by Rachel Radford on 12/16/23.
//

import SwiftUI
import SwiftData

struct ChristmasImageView: View {
    @Environment(\.modelContext) var modelContext
    @Query var images: [Images]
    @AppStorage("isDarkMode") private var isDarkMode = false
    @State private var isDownloaded = false
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
                            .onTapGesture {
                                let renderer = ImageRenderer(content: urlImage)
                                
                                if let image = renderer.uiImage {
                                    isDownloaded = true
                                    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                                }
                            }.alert(isPresented: $isDownloaded) {
                                Alert(title: Text("Your image has beeen downloaded!"), message: Text(""), dismissButton: .default(Text("Got it!")))
                            }
                    } placeholder: {
                        ProgressView(String("🎄"))
                    }
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
    }
}

