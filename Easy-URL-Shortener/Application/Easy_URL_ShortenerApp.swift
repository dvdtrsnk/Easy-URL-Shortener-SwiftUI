//
//  Easy_URL_ShortenerApp.swift
//  Easy-URL-Shortener
//
//  Created by David Třešňák on 03.01.2024.
//

import SwiftData
import SwiftUI

@main
struct Easy_URL_ShortenerApp: App {
    // MARK: - Properties
    let modelContext: ModelContext

    // MARK: - Init
    init() {
        modelContext = try! ModelContainer(for: ShortUrlModel.self).mainContext
    }
    
    // MARK: - Body
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    if UserDefaults.standard.appColorTheme.isEmpty {
                        UserDefaults.standard.appColorTheme = "#223F9CEC"
                    }
                }
        }
    }
}
