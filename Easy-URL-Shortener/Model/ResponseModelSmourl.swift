//
//  ResponseModelSmourl.swift
//  Easy-URL-Shortener
//
//  Created by David Třešňák on 26.01.2024.
//

import Foundation

struct ResponseModelSmourl: Codable {
    let data: URLData

    struct URLData: Codable {
        let destinationURL: URL
        let shortURL: URL

        enum CodingKeys: String, CodingKey {
            case destinationURL = "destination_url"
            case shortURL = "short_url"
        }
    }
}
