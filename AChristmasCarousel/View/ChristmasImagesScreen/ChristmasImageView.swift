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
        DarkModeView()
        
        
        TabView {
            
            ForEach(images, id: \.self) { image in
                
                AsyncImage(url: URL(string: image.urls.regular)) { urlImage in
                   RoundedRectangle(cornerRadius: 20)
                        .foregroundStyle(isDarkMode ? Color.xmasGreen : Color.xmasRed)
                        .frame(width: 250, height: 250)
                        .overlay {
                    urlImage
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 250)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        
                           
                        }
                    
                    
                } placeholder: {
                    ProgressView(String("🎄"))
                }
            }
            
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        
        
    }
}
