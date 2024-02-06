//
//  APIServiceProtocol.swift
//  Easy-URL-Shortener
//
//  Created by David Třešňák on 26.01.2024.
//

import Foundation
import Factory

// MARK: - Custom errors
enum APIServiceError: Error {
    case badURL
    case decodingError
    case sessionError
}

// MARK: - Protocol
protocol APIServiceProtocol {
    func getData(urlString: String) async throws -> ShortUrlModel
}

// MARK: - List of services
enum APIService: CaseIterable {
    case ulvis
    case smolurl
    
    var adress: String {
        switch self {
        case .ulvis:
            return "ulvis.net"
        case .smolurl:
            return "SmolUrl.com"
        }
    }
    
    var service: APIServiceProtocol {
        switch self {
        case .ulvis:
            @Injected(\.apiServiceUlvis) var service
            return service
        case .smolurl:
            @Injected(\.apiServiceSmolurl) var service
            return service
        }
    }
}
