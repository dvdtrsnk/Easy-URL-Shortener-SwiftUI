//
//  AppBackground.swift
//  Easy-URL-Shortener
//
//  Created by David Třešňák on 03.01.2024.
//

import SwiftUI

// MARK: - View+ Modifier
extension View {
    func appStyleBackground(_ color: Color) -> some View {
        self
            .modifier(AppStyleBackground(color: color))
    }
}

// MARK: - ViewModifier
struct AppStyleBackground: ViewModifier {
    // MARK: - Properties
    @Environment(\.colorScheme) var colorScheme
    
    var color: Color
    var lighterColor: Color {
        color.lighter(by: 25)
    }
    var darkerColor: Color {
        color.darker(by: 25)
    }
    
    // MARK: - Body
    func body(content: Content) -> some View {
        content
            .background {
                ZStack {
                    LinearGradient(gradient:
                                    Gradient(colors:
                                                [lighterColor, darkerColor]),
                                   startPoint: .top,
                                   endPoint: .bottom)
        
                    Color.black.opacity(colorScheme == .dark ? 0.5 : 0)
                }
                .ignoresSafeArea()                
            }
    }
}

// MARK: - Mock + Preview
struct MockAppBackgroundView: View {
    var body: some View {
        VStack {
            Text("Hello world!")
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .appStyleBackground(.blue)
    }
}
#Preview {
        MockAppBackgroundView()
}
