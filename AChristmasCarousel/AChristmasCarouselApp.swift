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
    let container = try! ModelContainer(for: Results.self)
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Results.self)
    }
}
