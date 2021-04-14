//
//  PantryManagerApp.swift
//  PantryManager
//
//  Created by Davide Andreoli on 13/04/21.
//

import SwiftUI

@main
struct PantryManagerApp: App {
    let viewModel = PantryManagerViewModel()
    
    var body: some Scene {
        WindowGroup {
            TabView {
                PantryView(pantryViewModel: viewModel)
                    .tabItem {
                        Label("Pantry", systemImage: "archivebox")
                    }.tag(1)
                Text("Tab Content 1")
                    .tabItem {
                        Label("Fridge", systemImage: "dial.min")
                    }.tag(2)
                Text("Tab Content 2")
                    .tabItem {
                        Label("Freezer", systemImage: "snow")
                    }.tag(3)
            }
        }
    }
}
