//
//  Text+.swift
//  Easy-URL-Shortener
//
//  Created by David Třešňák on 03.01.2024.
//

import SwiftUI

// MARK: - App Title Style
extension Text {
    func appTitleStyle() -> some View {
        return self
            .font(.largeTitle)
            .foregroundStyle(.white)
            .shadow(color: Color.black, radius: 0, x: 3, y: 3)
    }
}
