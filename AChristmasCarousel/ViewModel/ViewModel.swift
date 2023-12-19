//
//  ViewModel.swift
//  AChristmasCarousel
//
//  Created by Rachel Radford on 12/16/23.
//

import Foundation

@MainActor
class GlobalViewModel: ObservableObject {
    @Published var isDarkMode: Bool = false
    @Published var results: Results?
    @Published var images: [Images] = []
    @Published var imageDescription: [String] = []
  //  @Published var user: [User] = []
}
