//
//  SettingsView.swift
//  PantryManager
//
//  Created by Davide Andreoli on 30/11/22.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var dataManager: DataManager
    @State private var confirmDataHasBeenAdded = false
    @State private var locationsAdded: Int = 0
    @State private var itemsAdded: Int = 0
    
    var body: some View {
    
        NavigationView {
            Form {
    #if targetEnvironment(simulator)
                Button("Nuke") {
                    dataManager.nuke()
                }
    #endif

            }
            .navigationTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
