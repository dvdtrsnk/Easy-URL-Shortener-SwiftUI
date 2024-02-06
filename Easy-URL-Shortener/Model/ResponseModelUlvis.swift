//
//  ResponseModelUlvis.swift
//  Easy-URL-Shortener
//
//  Created by David Třešňák on 03.01.2024.
//

import Foundation

class ResponseModelUlvis: Codable {
    let success: Bool
    let data: ShortUrlModel
}
