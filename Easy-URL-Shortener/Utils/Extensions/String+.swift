//
//  String+.swift
//  Easy-URL-Shortener
//
//  Created by David Třešňák on 04.01.2024.
//

import SwiftUI

// MARK: - Remove https:// or https:// from String
extension String {
    func removeHttp() -> String {
        self.replacingOccurrences(of: "http://", with: "").replacingOccurrences(of: "https://", with: "")
    }
}

// MARK: - String to Color
extension String {
    func rgbaToColor() -> Color {
        var hexSanitized = self.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let red = Double((rgb & 0xFF000000) >> 24) / 255.0
        let green = Double((rgb & 0x00FF0000) >> 16) / 255.0
        let blue = Double((rgb & 0x0000FF00) >> 8) / 255.0
        let alpha = Double(rgb & 0x000000FF) / 255.0
        
        return Color(red: red, green: green, blue: blue, opacity: alpha)
    }
}
