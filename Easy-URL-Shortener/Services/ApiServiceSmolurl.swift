//
//  ApiServiceSmolurl.swift
//  Easy-URL-Shortener
//
//  Created by David Třešňák on 26.01.2024.
//

import Foundation

final class ApiServiceSmolurl: APIServiceProtocol {
    // MARK: - Properties
    private let serviceUrl = URL(string: "https://smolurl.com/api/links")!
    
    // MARK: - Functions
    func getData(urlString: String) async throws -> ShortUrlModel {
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let requestBody = ["url": urlString]
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: requestBody) else {
            throw APIServiceError.sessionError
        }
        
        request.httpBody = jsonData
        
        guard let (data, _) = try? await URLSession.shared.data(for: request) else {
            throw APIServiceError.sessionError
        }
        
        guard let decodedData = try? JSONDecoder().decode(ResponseModelSmourl.self, from: data) else {
            throw APIServiceError.decodingError
        }
        
        return ShortUrlModel(id: UUID().uuidString,
                             url: decodedData.data.shortURL.absoluteString,
                             full: decodedData.data.destinationURL.absoluteString)
    }
}
