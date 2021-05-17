//
//  PantryManagerViewModel.swift
//  PantryManager
//
//  Created by Davide Andreoli on 14/04/21.
//

import Foundation
import SwiftUI
import CoreData
import Combine

class PantryManagerViewModel: ObservableObject {
    
    @Published var pantryManagerModel = PantryManager()
    
    // Returns all the items in the model
    var items: [LocalFoodItem] {
        return pantryManagerModel.items
    }
    // Returns all the storages in the model
    var storages: [String] {
        return pantryManagerModel.storages
    }
    
    // Add one item to the item array
    func add(_ item: LocalFoodItem) {
        pantryManagerModel.items.append(item)
    }
    //Create an item in the database
    func create(name: String, expiryDate: Date, storage: FoodStorage, in database: NSManagedObjectContext) {
        let newItem = FoodItem(context: database)
        newItem.name = name
        newItem.id = UUID()
        newItem.expiryDate = expiryDate
        newItem.storage = storage
        try? database.save()

    }
    // Delete item function, for removal with IndexSet
    func delete(at indexSet: IndexSet, from storage: String) {
        //The item array contains all the items in all orders, but the index set refers to the filtered list
        let newList = pantryManagerModel.items.filter { $0.storage == storage }
        // Items to be deleted
        var itemsToBeDeleted = [LocalFoodItem]()
        // Iterate over the indices and add the corresponding element to a dedicated array
        for index in indexSet {
            itemsToBeDeleted.append(newList[index])
        }
        // Iterate over the items to be deleted
        for item in itemsToBeDeleted {
            // Recover the index of the element to be deleted by recovering the element with the same id in the items array
            if let index = pantryManagerModel.items.firstIndex(matching: item) {
                // Remove the element
                pantryManagerModel.items.remove(at: index)
            }
        }
        
        
    }
    // Delete item function, for removal with an item directly
    func delete(_ item: LocalFoodItem) {
        // Recover the index of the element to be deleted by recovering the element with the same id in the items array
        if let index = pantryManagerModel.items.firstIndex(matching: item) {
            // Remove the element
            pantryManagerModel.items.remove(at: index)
        }
    }
    // Delete item function, for removal with an item directly
    func delete(_ item: FoodItem, from database: NSManagedObjectContext) {


        database.delete(item)
        try? database.save()
    }
}
