//
//  PantryManagerViewModel.swift
//  PantryManager
//
//  Created by Davide Andreoli on 14/04/21.
//

import Foundation
import SwiftUI

class PantryManagerViewModel: ObservableObject {
    
    @Published var pantryManagerModel = PantryManager()
    
    // Returns all the items in the model
    var items: [FoodItem] {
        return pantryManagerModel.items
    }
    // Returns all the storages in the model
    var storages: [String] {
        return pantryManagerModel.storages
    }
    
    // Add one item to the item array
    func add(_ item: FoodItem) {
        pantryManagerModel.items.append(item)
    }
    // Delete item function, for removal with IndexSet
    func delete(at indexSet: IndexSet, from storage: String) {
        //The item array contains all the items in all orders, but the index set refers to the filtered list
        let newList = pantryManagerModel.items.filter { $0.storage == storage }
        // Items to be deleted
        var itemsToBeDeleted = [FoodItem]()
        // Iterate over the indices and add the corresponding element to a dedicated array
        for index in indexSet {
            itemsToBeDeleted.append(newList[index])
        }
        // Iterate over the items to be deleted
        for item in itemsToBeDeleted {
            // Recover the index of the element to be deleted by recovering the element with the same id in the items array
            if let index = pantryManagerModel.items.firstIndex(where: {$0.id == item.id}) {
                // Remove the element
                pantryManagerModel.items.remove(at: index)
            }
        }
        
        
    }
    // Delete item function, for removal with an item directly
    func delete(_ item: FoodItem) {
        // Recover the index of the element to be deleted by recovering the element with the same id in the items array
        if let index = pantryManagerModel.items.firstIndex(where: {$0.id == item.id}) {
            // Remove the element
            pantryManagerModel.items.remove(at: index)
        }
    }
}
