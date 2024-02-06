//
//  App+DependencyInjections.swift
//  Easy-URL-Shortener
//
//  Created by David Třešňák on 26.01.2024.
//

import Foundation
import SwiftData
import Factory

extension Container {
    var modelContext: Factory<ModelContext> {
        self { Easy_URL_ShortenerApp().modelContext }.singleton
    }
    var apiServiceUlvis: Factory<APIServiceProtocol> {
        self { ApiServiceUlvis() }
    }
    var apiServiceSmolurl: Factory<APIServiceProtocol> {
        self { ApiServiceSmolurl() }
    }
}
