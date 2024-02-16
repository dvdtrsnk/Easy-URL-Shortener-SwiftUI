//
//  UserDefaults+.swift
//  Easy-URL-Shortener
//
//  Created by David Třešňák on 02.02.2024.
//

import SwiftUI

// MARK: - keyPaths for known Keys
extension UserDefaults {
    @objc dynamic var appColorTheme: String {
        get {
            return string(forKey: "appColorTheme") ?? "#2F52C6EC"
        }
        set {
            set(newValue, forKey: "appColorTheme")
        }
    }
    
    @objc dynamic var alwaysDarkmode: Bool {
        get {
            return bool(forKey: "alwaysDarkmode")
        }
        set {
            set(newValue, forKey: "alwaysDarkmode")
        }
    }
}
