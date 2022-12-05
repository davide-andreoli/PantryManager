//
//  PantryManagerApp.swift
//  PantryManager
//
//  Created by Davide Andreoli on 13/04/21.
//

import SwiftUI
import CoreData

@main
struct PantryManagerApp: App {
    @StateObject var dataManager = DataManager()
    let viewModel = PantryManagerViewModel()
    
    var body: some Scene {
        WindowGroup {
            TabView {
                StoragesListView(viewModel: viewModel)
                    .tabItem {
                        Label("Storages", systemImage: "archivebox")
                    }.tag(1)
                Text("Tab Content 1")
                    .tabItem {
                        Label("Categories", systemImage: "dial.min")
                    }.tag(2)
                SettingsView()
                    .tabItem {
                        Label("Settings", systemImage: "gear")
                    }.tag(3)
            }
            .environmentObject(dataManager)
            
            .onAppear {
               initializeData()
            }
        }
    }
    
    func initializeData() {
        // MARK: TO DO - Rewrite this
        /*
        dataManager.managedObjectContext.reset()
        // Clear the database --> will have to implement the app filling only at first launch
        var fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "FoodStorage")
        var deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        try! dataManager.managedObjectContext.execute(deleteRequest)
        fetchRequest = NSFetchRequest(entityName: "FoodItem")
        deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        try! dataManager.managedObjectContext.execute(deleteRequest)
        
        let foodStorage = FoodStorage(context: dataManager.managedObjectContext)
        foodStorage.name = "Pantry"
        foodStorage.id = UUID()
        foodStorage.iconName = "bag.fill"
        
        let foodStorage2 = FoodStorage(context: dataManager.managedObjectContext)
        foodStorage2.name = "Fridge"
        foodStorage2.id = UUID()
        foodStorage.iconName = "snowflake"
        
        let foodItem = FoodItem(context: dataManager.managedObjectContext)
        foodItem.name = "Eggs"
        foodItem.id = UUID()
        foodItem.quantity = 1
        foodItem.expiryDate = Date()
        foodItem.storage = foodStorage
        
        let foodItem2 = FoodItem(context: dataManager.managedObjectContext)
        foodItem2.name = "Milk"
        foodItem2.id = UUID()
        foodItem2.quantity = 1
        foodItem2.expiryDate = Date()
        foodItem2.storage = foodStorage2
        
        try? dataManager.managedObjectContext.save()
        */
   
    }

}
