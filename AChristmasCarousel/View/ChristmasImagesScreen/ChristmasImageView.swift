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
    @Query var images: [Images] = []
    let layout = [GridItem(.fixed(100)),
                  GridItem(.fixed(100)),
                  GridItem(.fixed(100)),
                  GridItem(.fixed(100)),
                  GridItem(.fixed(100)),
                  GridItem(.fixed(100)),
                  GridItem(.fixed(100)),
                  GridItem(.fixed(100)),
                  GridItem(.fixed(100)),
                  GridItem(.fixed(100))
    ]
    var body: some View {
        DarkModeView()
        Spacer()
        ScrollView(.horizontal, showsIndicators: false) {
            LazyVGrid(columns: layout) {
                ForEach(images, id: \.hashValue) { image in
                    AsyncImage(url: URL(string: image.urls.regular)) { urlImage in
                        urlImage
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                    } placeholder: {
                        ProgressView()
                    }
                }
            }
        }.padding(.top, 100)
    }
}
