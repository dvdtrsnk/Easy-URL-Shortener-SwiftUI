//
//  SearchView.swift
//  Easy-URL-Shortener
//
//  Created by David Třešňák on 03.01.2024.
//

import SwiftUI
import SwiftfulLoadingIndicators

struct SearchView: View {
    // MARK: - Properties
    @State private var vm = SearchViewModel()

    // MARK: - Body
    var body: some View {
        VStack {
            List {
                AppStyleSection(title: ">URL<") {
                    VStack(spacing: 20) {
                        switch vm.searchState {
                        case .empty:
                            emptyStateView
                        case .result(let data):
                            resultStateView(data)
                        case .invalidUrl:
                            invalidUrlStateView
                        case .error:
                            errorStateView
                        case .loading:
                            loadingStateView
                        }
                    }
                    .multilineTextAlignment(.center)
                }
                
                AppStyleSection(title: "Services") {
                    ForEach(APIService.allCases, id: \.self) { service in
                        Button {
                            vm.urlShortener = service
                        } label: {
                            HStack {
                                Text(service.adress)
                                    .foregroundStyle(.foregroundPrimary)
                                
                                Spacer()
                                
                                if service == vm.urlShortener {
                                    Image(systemName: "checkmark")
                                        .foregroundStyle(vm.appColor)
                                }
                            }
                        }
                    }
                }
                
                AppStyleSection(title: "History") {
                    ForEach(vm.shortUrlModel) { data in
                        Button {
                            vm.shortenURL(data.full)
                        } label: {
                            Text(data.full)
                                .foregroundStyle(.foregroundPrimary)
                        }
                    }
                    .onDelete(perform: vm.deleteData)
                }
            }
            .onAppear {
                vm.fetchData()
            }
            .scrollContentBackground(.hidden)
            .padding(.bottom, 70)
            .overlay {
                VStack {
                    Spacer()
                    TextField("Shorten URL", text: $vm.searchField) {
                        vm.shortenURL(vm.searchField)
                    }
                        .textFieldStyle(AppStyleSearchTextfieldStyle($vm.searchField))
                        .padding()
                        .keyboardType(.URL)
                }
            }

            .appStylePopup(isPresented: $vm.showPopup)
        }
        .appStyleBackground(vm.appColor)
    }
}

// MARK: - Search State Views
extension SearchView {
    private var loadingStateView: some View {
        LoadingIndicator(animation: .threeBalls, color: .secondary)
            .frame(maxWidth: .infinity, minHeight: 80,alignment: .center)
    }
    
    private var emptyStateView: some View {
        Group {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(vm.appColor)
            
            Text("No result to show. Enter an address in the URL field to proceed.")
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
    
    private var invalidUrlStateView: some View {
        Group {
            Image(systemName: "rectangle.and.pencil.and.ellipsis")
                .foregroundStyle(.yellow)
            
            Text("Invalid URL! Make sure to include 'http://' or 'https://' for a valid URL.")
        }
    }
    
    private var errorStateView: some View {
        Group {
            Image(systemName: "exclamationmark.icloud.fill")
                .foregroundStyle(.red)
            
            Text("Error! Please check your internet connection. If the issue persists, kindly contact us through the settings.")
        }
    }
    
    private func resultStateView(_ data: ShortUrlModel) -> some View {
        Group {
            Text("Filled URL:")
                .foregroundStyle(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.caption)
            
            Text(data.full.lowercased())
            
            Text("Short URL:")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.caption)
                .foregroundStyle(.gray)
            
            Text(data.url.removeHttp())

            HStack {
                Spacer()
                
                Button {
                    vm.copyToClipboard(data.url.removeHttp())
                } label: {
                    Label("Copy", systemImage: "doc.on.doc")
                }
                
                Spacer()
                
                if UIDevice.current.userInterfaceIdiom == .phone {
                    Button {
                        shareUrl(data.url)
                    } label: {
                        Label("Share", systemImage: "square.and.arrow.up")
                    }
                    
                    Spacer()
                }
                                
                Button {
                    vm.showPopup = .qrCode(data.full)
                } label: {
                    Label("QR", systemImage: "qrcode")
                }
                
                Spacer()
            }
            .buttonStyle(.borderless)
            .foregroundColor(vm.appColor)
        }
    }
}

// MARK: - UI Components
extension SearchView {
    private func shareUrl(_ urlString: String?) {
        if let urlString, let url = URL(string: urlString) {
            let activityView = UIActivityViewController(activityItems: [url], applicationActivities: nil)
            
            let allScenes = UIApplication.shared.connectedScenes
            let scene = allScenes.first { $0.activationState == .foregroundActive }
            
            if let windowScene = scene as? UIWindowScene {
                windowScene.keyWindow?.rootViewController?.present(activityView, animated: true, completion: nil)
            }
        }
    }
}
// MARK: - Preview
#Preview {
    SearchView()
}
