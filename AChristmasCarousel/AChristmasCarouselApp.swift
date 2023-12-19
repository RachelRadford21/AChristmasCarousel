//
//  AChristmasCarouselApp.swift
//  AChristmasCarousel
//
//  Created by Rachel Radford on 12/16/23.
//

import SwiftUI
import SwiftData

@main
struct AChristmasCarouselApp: App {
    @StateObject var vm = GlobalViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(vm)
        }
        .modelContainer(for: Results.self)
    }
}
