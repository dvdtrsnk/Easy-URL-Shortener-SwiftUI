//
//  Binding+.swift
//  Easy-URL-Shortener
//
//  Created by David Třešňák on 25.01.2024.
//

import SwiftUI

// MARK: - Determine Bool based on nil or not nil
extension Binding where Value == Bool {
    init<T>(value: Binding<T?>) {
        self.init {
            value.wrappedValue != nil
        } set: { newValue in
            if !newValue {
                value.wrappedValue = nil
            }
        }
    }
}
