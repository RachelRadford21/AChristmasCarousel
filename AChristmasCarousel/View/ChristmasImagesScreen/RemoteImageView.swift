//
//  RemoteImageView.swift
//  AChristmasCarousel
//
//  Created by Rachel Radford on 12/15/24.
//

import SwiftUI
import SwiftData

struct RemoteImageView: View {
    @Environment(\.modelContext) var context
    @State private var isDownloaded = false
    @Query var images: [Images]
    var imageVM: ImageViewModel = ImageViewModel()
    
    var body: some View {
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
                            Alert(title: Text("Your image has been downloaded!"), message: Text(""), dismissButton: .default(Text("Got it!")))
                        }
                } placeholder: {
                    ProgressView(String("🎄"))
                }
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
    }
}

#Preview {
    RemoteImageView()
}
