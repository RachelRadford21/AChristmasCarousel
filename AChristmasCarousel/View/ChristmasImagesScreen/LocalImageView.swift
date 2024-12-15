//
//  LocalImageView.swift
//  AChristmasCarousel
//
//  Created by Rachel Radford on 12/14/24.
//

import SwiftUI
import SwiftData

struct LocalImageView: View {
    @State private var isDownloaded = false
    @State var localImages: [URL] = []
  
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(localImages, id: \.self) { image in
                    VStack {
                        ZStack {
                            if let uiImage = UIImage(contentsOfFile: image.path) {
                                
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 350, height: 350)
                                    .cornerRadius(10)
                                    .scrollTransition(.interactive(timingCurve: .circularEaseInOut), axis: .vertical) { content, phase in
                                        content
                                            .offset(y: phase.value * -250)
                                            .scaleEffect(phase.isIdentity ? 1 : 0.55)
                                    }
                                    .animation(Animation.spring(response: 1.0, dampingFraction: 0.0, blendDuration: 1.0), value: localImages)
                                    .onTapGesture {
                                        let renderer = ImageRenderer(content: Image(uiImage: uiImage))
                                        
                                        if let image = renderer.uiImage {
                                            isDownloaded = true
                                            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                                        }
                                    }
                                    .alert(isPresented: $isDownloaded) {
                                        Alert(title: Text("Your image \(image.lastPathComponent.description) has beeen downloaded!"), message: Text(""), dismissButton: .default(Text("Got it!")))
                                    }
                            }
                        }
                        .scrollTransition(.interactive(timingCurve: .circularEaseInOut), axis: .vertical) { content, phase in
                            content
                               .opacity(phase.isIdentity ? 1.0 : 0.8)
                        }
                    }
                }
            }
            .onAppear {
                loadLocalImages()
            }
        }
        .contentMargins(34)
        .scrollTargetLayout(isEnabled: true)
        .scrollTargetBehavior(.viewAligned)
        .scrollIndicators(.hidden)
    }
}

extension LocalImageView {
    func loadLocalImages() {
        if let folderURL = Bundle.main.url(forResource: "XmasImages", withExtension: nil) {
            do {
                let fileURLs = try FileManager.default.contentsOfDirectory(at: folderURL, includingPropertiesForKeys: nil)
                localImages = fileURLs
            } catch {
                print("Error accessing folder: \(error)")
            }
        } else {
            print("Folder not found in bundle.")
        }
    }
}


#Preview {
    LocalImageView()
}
