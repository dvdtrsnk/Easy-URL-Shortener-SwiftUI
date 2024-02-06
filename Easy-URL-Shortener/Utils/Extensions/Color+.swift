//
//  Color+.swift
//  Easy-URL-Shortener
//
//  Created by David Třešňák on 01.02.2024.
//

import SwiftUI

// MARK: - Lighter & Darker Color
extension Color {
    func lighter(by percentage: CGFloat = 30.0) -> Color {
        let uiColor = self.adjust(by: abs(percentage) ) ?? self
        return Color(uiColor)
    }

    func darker(by percentage: CGFloat = 30.0) -> Color {
        let uiColor =  self.adjust(by: -1 * abs(percentage) ) ?? self
        return Color(uiColor)

    }

    func adjust(by percentage: CGFloat = 30.0) -> Color? {
        var uiColor = UIColor(self)
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        if uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            uiColor = UIColor(red: min(red + percentage/100, 1.0),
                           green: min(green + percentage/100, 1.0),
                           blue: min(blue + percentage/100, 1.0),
                           alpha: alpha)
            return Color(uiColor)
        } else {
            return nil
        }
    }
}

// MARK: - Color To String
extension Color {
    func toRgbaString() -> String {
        let uiColor = UIColor(self)
        let components = uiColor.cgColor.components ?? [0.0, 0.0, 0.0, 0.0]
    
        let red = Int(components[0] * 255.0)
        let green = Int(components[1] * 255.0)
        let blue = Int(components[2] * 255.0)
        let alpha = Int(components[3] * 255.0)
        
        return String(format: "#%02X%02X%02X%02X", red, green, blue, alpha)
    }
}
