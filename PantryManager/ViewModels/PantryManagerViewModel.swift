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

    // Returns all the storages in the model

    //Create an item in the database
    func addItem(name: String, expiryDate: Date, quantity: Double, storage: FoodStorage, in database: NSManagedObjectContext) {
        let newItem = FoodItem(context: database)
        newItem.name = name
        newItem.id = UUID()
        newItem.expiryDate = expiryDate
        newItem.quantity = quantity
        newItem.storage = storage
        try? database.save()

    }

    // Delete item function, for removal with an item directly
    func deleteItem(_ item: FoodItem, from database: NSManagedObjectContext) {

        database.delete(item)
        try? database.save()
    }
}
