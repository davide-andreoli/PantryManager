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
                        Text("Label1")     
                    }.tag(1)
                Text("Tab Content 1")
                    .tabItem {
                        Text("Label1")
                    }.tag(2)
                Text("Tab Content 2")
                    .tabItem {
                        Text("Label 2")
                    }.tag(3)
            }
        }
    }
}
