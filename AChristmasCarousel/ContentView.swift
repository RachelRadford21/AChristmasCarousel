//
//  ContentView.swift
//  AChristmasCarousel
//
//  Created by Rachel Radford on 12/16/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var vm:ViewModel
    @State private var isActive = false
    var body: some View {
        ZStack {
            Color.xmasGreen.ignoresSafeArea()
            if self.isActive {
                ChristmasImageView(vm: vm)
            } else {
                VStack {
                    Image("Christmas Carousel")
                        .resizable()
                        .scaledToFit()
                }
            }
        }.onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
