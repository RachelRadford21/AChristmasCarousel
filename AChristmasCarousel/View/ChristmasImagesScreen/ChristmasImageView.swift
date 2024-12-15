//
//  ChristmasImageView.swift
//  AChristmasCarousel
//
//  Created by Rachel Radford on 12/16/23.
//

import SwiftUI
import SwiftData

struct ChristmasImageView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    @Binding var localImages: [URL]
    @Query var images: [Images]
    var imageVM: ImageViewModel = ImageViewModel()
   
    init(
        localImages: Binding<[URL]> = .constant([])
    ) {
        self._localImages = localImages
    }
    
    var body: some View {
        VStack {
            DarkModeView()
            
            if images.isEmpty {
                LocalImageView()
            } else {
                RemoteImageView()

            }
        }
        .refreshable {
            await imageVM.fetchImages()
        }.task {
            await imageVM.fetchImages()

        }
    }
}


