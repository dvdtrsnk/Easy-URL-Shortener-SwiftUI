//
//  UlvisApiService.swift
//  Easy-URL-Shortener
//
//  Created by David Třešňák on 26.01.2024.
//

import Foundation

final class ApiServiceUlvis: APIServiceProtocol {
    // MARK: - Properties
    private let serviceUrl: String = "https://ulvis.net/API/write/get?url="
    
    // MARK: - Functions
    func getData(urlString: String) async throws -> ShortUrlModel {
        guard let url = URL(string: serviceUrl+urlString) else {
            throw APIServiceError.badURL
        }
        
        guard let (data, _) = try? await URLSession.shared.data(from: url) else {
            throw APIServiceError.sessionError
        }
        
        if let failure = String(data: data, encoding: .utf8)?.contains("\"success\":false") {
            if failure {
                throw APIServiceError.badURL
            }
        }
        
        guard let decodedData = try? JSONDecoder().decode(ResponseModelUlvis.self, from: data) else {
            throw APIServiceError.decodingError
        }

        return decodedData.data
    }
}
