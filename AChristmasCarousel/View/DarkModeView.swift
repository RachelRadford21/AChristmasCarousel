//
//  DarkModeView.swift
//  AChristmasCarousel
//
//  Created by Rachel Radford on 12/17/23.
//

import SwiftUI

struct DarkModeView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    var body: some View {
        VStack(alignment: .leading) {
            Toggle("", isOn: $isDarkMode)
        }
    }
}

#Preview {
    DarkModeView()
}
