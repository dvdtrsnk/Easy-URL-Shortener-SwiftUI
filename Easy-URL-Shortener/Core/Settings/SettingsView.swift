//
//  SettingsView.swift
//  Easy-URL-Shortener
//
//  Created by David Třešňák on 03.01.2024.
//

import SwiftUI

struct SettingsView: View {
    // MARK: - Properties
    @State private var vm = SettingsViewModel() 
    @Environment(\.openURL) var openURL

    // MARK: - Body
    var body: some View {
        VStack {
            List {
                AppStyleSection(title: "Settings") {
                    Section {
                        appColor
                        alwaysDarmode
                        supportWebsite
                        deleteHistory
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .padding(.bottom, 70)
        }
        .animation(.linear, value: vm.appColor)
        .animation(.linear, value: vm.alwaysDarkmode)
        .appStyleBackground(vm.appColor)
        .alert(isPresented: $vm.showDeleteHistoryAlert) {
            Alert(
                title: Text("Delete History"),
                message: Text("Are you sure?"),
                primaryButton: .destructive(Text("Delete")) {
                    vm.deleteHistory()
                },
                secondaryButton: .cancel()
            )
        }

    }
}

// MARK: - Setting Options
extension SettingsView {
    private var appColor: some View {
        Label {
            ColorPicker("App color", selection: $vm.appColorSetter)
        } icon: {
            Image(systemName: "paintpalette.fill")
                .foregroundStyle(vm.appColorSetter)
        }
    }
    
    private var alwaysDarmode: some View {
        Label {
            Toggle("Always darkmode", isOn: $vm.alwaysDarkmodeSetter)
        } icon: {
            Image(systemName: "circle.lefthalf.filled.inverse")
                .foregroundStyle(vm.appColorSetter)
        }
    }
    
    private var supportWebsite: some View {
        Button {
            openURL(URL(string: "https://www.dvdtrsnk.worpress.com/")!)
        } label: {
            Label {
                Text("App website")
                    .foregroundStyle(.foregroundPrimary)
            } icon: {
                Image(systemName: "network")
            }
        }
    }
    
    private var deleteHistory: some View {
        Button {
            vm.showDeleteHistoryAlert.toggle()
        } label: {
            Label {
                Text("Delete history")
                    .foregroundStyle(.foregroundPrimary)
            } icon: {
                Image(systemName: "trash.fill")
                    .foregroundStyle(vm.appColorSetter)
            }
        }
    }
}

// MARK: - Preview
#Preview {
    SettingsView()
}
