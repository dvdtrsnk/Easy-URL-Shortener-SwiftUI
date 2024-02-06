//
//  ContentViewModel.swift
//  Easy-URL-Shortener
//
//  Created by David Třešňák on 05.02.2024.
//

import Combine
import SwiftUI
import Observation

@Observable
final class ContentViewModel: UserDefaultsSubscriber {
    // MARK: - Properties
    var appColor: Color = .blue
    var alwaysDarkmode: Bool = false
    var cancellables: Set<AnyCancellable> = []
    
    // MARK: - Init
    init() {
        addSubscribers()
    }
    
}
