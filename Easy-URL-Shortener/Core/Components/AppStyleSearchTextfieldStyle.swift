//
//  SearchTextfieldStyle.swift
//  Easy-URL-Shortener
//
//  Created by David Třešňák on 03.01.2024.
//

import SwiftUI

struct AppStyleSearchTextfieldStyle: TextFieldStyle {
    // MARK: - Properties
    @Binding var searchField: String
    
    // MARK: - Init
    init(_ searchField: Binding<String>) {
        _searchField = searchField
    }
    
    // MARK: - Body
    func _body(configuration: TextField<Self._Label>) -> some View {
        HStack {
            Image(systemName: "magnifyingglass")
            configuration
            
            Group {
                if searchField.isEmpty {
                    Button {
                        if let clipboardString = UIPasteboard.general.string {
                            searchField = clipboardString
                        }
                    } label: {
                        HStack {
                            Label("Paste", systemImage: "doc.on.doc")
                        }
                    }
                } else {
                    Button {
                        searchField = ""
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(.gray)
                    }
                }
            }
        }
        .padding(10)
        .background(Color.backgroundPrimary)
        .cornerRadius(10)
        .gesture(DragGesture().onChanged {_ in
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)

        })
    }
}

// MARK: - Mock + Preview
struct MockTextfieldStyle: View {
    @State private var searchField: String = ""
    var body: some View {
        VStack {
            Spacer()
            
            TextField("Shorten URL", text: $searchField)
                .textFieldStyle(AppStyleSearchTextfieldStyle($searchField))
                .padding()
        }
        .appStyleBackground(.blue)
    }
}

#Preview {
    MockTextfieldStyle()
}
