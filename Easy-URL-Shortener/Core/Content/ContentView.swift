//
//  ContentView.swift
//  Easy-URL-Shortener
//
//  Created by David Třešňák on 03.01.2024.
//

import SwiftUI

struct ContentView: View {
    // MARK: - Properties
    @State private var vm = ContentViewModel()

    // MARK: - Body
    var body: some View {
        TabView {
            SearchView()
                .tabItem {
                    Label("Search", systemImage: "network")
                }
                .tint(vm.appColor)
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
                .tint(vm.appColor)
        }
        .tint(.white)
        .onAppear {
            UITabBar.appearance().unselectedItemTintColor = UIColor.gray
            UITabBar.appearance().backgroundColor = UIColor.clear
        }
        .preferredColorScheme(vm.alwaysDarkmode ? .dark : .none)
    }
}

// MARK: - Preview
#Preview {
    ContentView()
}
