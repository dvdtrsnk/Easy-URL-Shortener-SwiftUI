//
//  SettingsViewModel.swift
//  Easy-URL-Shortener
//
//  Created by David Třešňák on 01.02.2024.
//

import Combine
import Factory
import SwiftData
import SwiftUI

@Observable
final class SettingsViewModel: UserDefaultsSubscriber {
    // MARK: - Properties
    @ObservationIgnored @Injected(\.modelContext) private var modelContext

    var appColor: Color = .blue
    var alwaysDarkmode: Bool = false
    var cancellables: Set<AnyCancellable> = []
    
    var showDeleteHistoryAlert = false
    
    var appColorSetter: Color {
        get {
            access(keyPath: \.appColorSetter)
            let colorRGBA = UserDefaults.standard.appColorTheme
            return colorRGBA.rgbaToColor()
        }
        set {
            withMutation(keyPath: \.appColorSetter) {
                print(newValue.toRgbaString())
                UserDefaults.standard.appColorTheme = newValue.toRgbaString()
            }
        }
    }
    var alwaysDarkmodeSetter: Bool {
        get {
            access(keyPath: \.alwaysDarkmode)
            return UserDefaults.standard.alwaysDarkmode
        }
        set {
            withMutation(keyPath: \.appColorSetter) {
                UserDefaults.standard.alwaysDarkmode = newValue
            }
        }
    }
    
    // MARK: - Init
    init() {
        addSubscribers()
    }
    
    // MARK: - Functions
    func deleteHistory() {
        let descriptor = FetchDescriptor<ShortUrlModel>(sortBy: [SortDescriptor(\.date, order: .reverse)])
        try? modelContext.fetch(descriptor).forEach {
            modelContext.delete($0)
        }
    }
}
