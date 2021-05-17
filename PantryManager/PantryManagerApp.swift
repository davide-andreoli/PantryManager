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
    let viewModel = PantryManagerViewModel()
    let persistenceController = PersistenceController.shared
    
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
                Text("Tab Content 2")
                    .tabItem {
                        Label("Settings", systemImage: "gear")
                    }.tag(3)
            }
            .environment(\.managedObjectContext, persistenceController.container.viewContext)
            .onAppear {
                initializeData()
            }
        }
    }
    
    func initializeData() {
        // Clear the database --> will have to implement the app filling only at first launch
        var fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "FoodStorage")
        var deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        try? persistenceController.container.viewContext.execute(deleteRequest)
        fetchRequest = NSFetchRequest(entityName: "FoodItem")
        deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        try? persistenceController.container.viewContext.execute(deleteRequest)
        
        let foodStorage = FoodStorage(context: persistenceController.container.viewContext)
        foodStorage.name = "Pantry"
        foodStorage.id = UUID()
        
        let foodStorage2 = FoodStorage(context: persistenceController.container.viewContext)
        foodStorage2.name = "Fridge"
        foodStorage2.id = UUID()
        
        let foodItem = FoodItem(context: persistenceController.container.viewContext)
        foodItem.name = "Eggs"
        foodItem.id = UUID()
        foodItem.quantity = 1
        foodItem.expiryDate = Date()
        foodItem.storage = foodStorage
        print(foodItem.quantity)
        
        try? persistenceController.container.viewContext.save()
        
        persistenceController.container.viewContext.undoManager = UndoManager()
    }
}
