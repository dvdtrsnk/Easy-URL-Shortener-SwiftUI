//
//  SearchViewModel.swift
//  Easy-URL-Shortener
//
//  Created by David Třešňák on 25.01.2024.
//

import SwiftData
import SwiftUI
import Factory
import Combine

@Observable
final class SearchViewModel: UserDefaultsSubscriber {
    // MARK: - Properties
    var appColor: Color = .blue
    var alwaysDarkmode: Bool = false
    var cancellables: Set<AnyCancellable> = []

    var searchField: String = ""
    var urlShortener: APIService = .ulvis
    var searchState: SearchState = .empty
    var showPopup: PopupType?
    
    @ObservationIgnored @Injected(\.modelContext) private var modelContext
    var shortUrlModel = [ShortUrlModel]()
    
    // MARK: - Enums
    enum SearchState {
        case empty
        case loading
        case invalidUrl
        case error
        case result(data: ShortUrlModel)
    }
    
    // MARK: - Init
    init() {
        addSubscribers()
    }
    // MARK: - Functions
    func copyToClipboard(_ text: String) {
        UIPasteboard.general.string = text
        showPopup = .text("Copied to clipboard")
    }
    
    func shortenURL(_ url: String) {
        Task {
            searchState = .loading
            do {
                try validateUrl(url)
                let shortUrlModel = try await urlShortener.service.getData(urlString: url)
                searchState = .result(data: shortUrlModel)
                addData(shortUrlModel)
            } catch {
                switch error {
                case APIServiceError.badURL: 
                    searchState = .invalidUrl
                default: 
                    searchState = .error
                }
            }
        }
    }
    
    func fetchData() {
        do {
            let descriptor = FetchDescriptor<ShortUrlModel>(sortBy: [SortDescriptor(\.date, order: .reverse)])
            shortUrlModel = try modelContext.fetch(descriptor)
        } catch {
            print("Fetch failed")
        }
    }
    
    func addData(_ data: ShortUrlModel) {
        fetchData()
    
        if let existingUrl = shortUrlModel.first(where: { $0.full == data.full } ) {
            modelContext.delete(existingUrl)
        }
        data.date = Date.now
        modelContext.insert(data)
        fetchData()
    }
    
    func deleteData(_ indexSet: IndexSet) {
        for index in indexSet {
            let shortUrl = shortUrlModel[index]
            modelContext.delete(shortUrl)
        }
        fetchData()
    }
    
    // MARK: - Private Functions
    private func validateUrl(_ urlString: String) throws {
        let httpPrefix = "http://"
        let httpsPrefix = "https://"
        
        guard urlString.lowercased().hasPrefix(httpPrefix.lowercased()) ||
                urlString.lowercased().hasPrefix(httpsPrefix.lowercased()) &&
                urlString.contains(".") else {
            throw APIServiceError.badURL
        }
    }
}
