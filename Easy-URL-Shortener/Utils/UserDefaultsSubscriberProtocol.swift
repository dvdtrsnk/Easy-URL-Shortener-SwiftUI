//
//  UserDefaultsSubscriberProtocol.swift
//  Easy-URL-Shortener
//
//  Created by David Třešňák on 05.02.2024.
//

import Combine
import SwiftUI

protocol UserDefaultsSubscriber: AnyObject {
    var appColor: Color { get set }
    var alwaysDarkmode: Bool { get set }
    var cancellables: Set<AnyCancellable> { get set }
    
    func addSubscribers()
}

extension UserDefaultsSubscriber {
    func addSubscribers() {
        
        var isPreview: Bool {
            return ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
        }
        
        if !isPreview {
            UserDefaults.standard
                .publisher(for: \.appColorTheme)
                .handleEvents(receiveOutput: { [weak self] value in
                    guard let self else { return }
                    print(value)
                    appColor = value.rgbaToColor()
                })
                .sink { _ in }
                .store(in: &cancellables)
            
            UserDefaults.standard
                .publisher(for: \.alwaysDarkmode)
                .handleEvents(receiveOutput: { [weak self] value in
                    guard let self else { return }
                    alwaysDarkmode = value
                })
                .sink { _ in }
                .store(in: &cancellables)
        }
    }

}
