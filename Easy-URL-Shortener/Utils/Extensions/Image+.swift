//
//  Image+.swift
//  Easy-URL-Shortener
//
//  Created by David Třešňák on 25.01.2024.
//

import SwiftUI
import QRCode

// MARK: - String to QR Code Image
extension Image {
    init(qrCodeFromString string: String) {
        if let url = URL(string: string) {
            let qrCode = QRCode(url: url, color: .white, backgroundColor: .clear)
            if let myImage: UIImage = try? qrCode?.image() {
                self.init(uiImage: myImage)
                return
            }
        }
        self.init(systemName: "xmark.circle.fill")
    }
}
