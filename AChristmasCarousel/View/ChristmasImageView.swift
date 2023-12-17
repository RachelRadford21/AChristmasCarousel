//
//  ChristmasImageView.swift
//  AChristmasCarousel
//
//  Created by Rachel Radford on 12/16/23.
//

import SwiftUI

struct ChristmasImageView: View {
    @ObservedObject var vm: ViewModel
    let columns = [GridItem(.flexible()), GridItem(.flexible()),GridItem(.flexible())]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
        LazyHGrid(rows: columns) {
            ForEach(vm.results, id: \.id) { image in
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
                await vm.fetchImages()
            }
        }
    }
    }
}

//#Preview {
//    ChristmasImageView()
//}
