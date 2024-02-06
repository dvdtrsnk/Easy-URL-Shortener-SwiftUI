//
//  AppStylePopup.swift
//  Easy-URL-Shortener
//
//  Created by David Třešňák on 25.01.2024.
//

import SwiftUI
import PopupView

// MARK: - View+ Modifier
extension View {
    func appStylePopup(isPresented: Binding<PopupType?>) -> some View {
        self.modifier(AppStylePopup(isPresented: isPresented))
    }
}

// MARK: - Enums
enum PopupType {
    case text(String)
    case qrCode(String)
}

struct AppStylePopup: ViewModifier {
    // MARK: - Properties
    @Binding var isPresented: PopupType?
    
    // MARK: - Body
    func body(content: Content) -> some View {
        ZStack {
            content
                .overlay {
                    if isPresented != nil {
                        Color.black.opacity(0.5)
                            .ignoresSafeArea()
                    }
                }
            
            switch isPresented {
            case .text(let string):
                Color.clear
                    .popup(isPresented: Binding(value: $isPresented)) {
                        Text(string)
                            .padding()
                            .padding(.horizontal, 16)
                            .background(
                                .thinMaterial,
                                in: RoundedRectangle(cornerRadius: 10, style: .continuous)
                            )
                            .frame(maxWidth: .infinity, alignment: .center)
                    } customize: {
                        $0
                            .appearFrom(.bottom)
                            .position(.center)
                            .animation(.bouncy)
                            .closeOnTapOutside(true)
                            .isOpaque(true)
                            .autohideIn(1.5)
                    }
            case .qrCode(let string):
                Color.clear
                    .popup(isPresented: Binding(value: $isPresented)) {
                        Image(qrCodeFromString: string)
                            .resizable()
                            .interpolation(.none)
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                            .padding()
                            .padding(.horizontal, 16)
                            .colorMultiply(.foregroundPrimary)
                            .background(
                                .thinMaterial,
                                in: RoundedRectangle(cornerRadius: 10, style: .continuous)
                            )
                            .frame(maxWidth: .infinity, alignment: .center)
                    } customize: {
                        $0
                            .appearFrom(.bottom)
                            .position(.center)
                            .animation(.bouncy)
                            .closeOnTapOutside(true)
                            .isOpaque(true)
                    }
            case nil:
                EmptyView()
            }
        }
        .animation(.bouncy, value: isPresented != nil)
    }
}

// MARK: - Preview
#Preview {
    VStack {
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .appStyleBackground(.blue)
    .appStylePopup(isPresented: .constant(.qrCode("https://www.google.com")))
}
