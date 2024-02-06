//
//  ShortURLModel.swift
//  Easy-URL-Shortener
//
//  Created by David Třešňák on 26.01.2024.
//

import Foundation
import SwiftData

// MARK: - ShortUrlModel
@Model
class ShortUrlModel: Codable {
    enum CodingKeys: CodingKey {
        case id
        case url
        case full
    }
    
    let id: String
    let url: String
    let full: String
    var date: Date?
    
    init(id: String, url: String, full: String) {
        self.id = id
        self.url = url
        self.full = full
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        url = try container.decode(String.self, forKey: .url)
        full = try container.decode(String.self, forKey: .full)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(url, forKey: .url)
        try container.encode(full, forKey: .full)
    }
}
