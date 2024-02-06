//
//  AppSection.swift
//  Easy-URL-Shortener
//
//  Created by David Třešňák on 25.01.2024.
//

import SwiftUI

struct AppStyleSection<Content: View>: View {
    // MARK: - Properties
    let title: String
    let content: () -> Content
    
    // MARK: - Body
    var body: some View {
        Section {
            content()
        } header: {
            Text(title)
                .appTitleStyle()
        }
    }
}

// MARK: - Preview
#Preview {
    VStack {
        List {
            AppStyleSection(title: "Preferences") {
                    ForEach(0..<10) {
                        Text("This is preview \($0)")
                    }
            }
        }
        .scrollContentBackground(.hidden)
        .appStyleBackground(.blue)
    }
}
