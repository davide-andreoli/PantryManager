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
    
    // MARK: TO DO - Rebuild the fetch requests into these lists
    
    @Published var listOfItems: [FoodItem] = []


    //Create an item in the database
    func addItem(name: String, expiryDate: Date, quantity: Double, quantityUnit: String, storage: FoodStorage, in database: NSManagedObjectContext) {
        let newItem = FoodItem(context: database)
        newItem.name = name
        newItem.id = UUID()
        newItem.expiryDate = expiryDate
        newItem.quantity = quantity
        newItem.storage = storage
        newItem.quantityUnit = quantityUnit
        newItem.objectWillChange.send()
        try? database.save()

    }

    // Delete item function, for removal with an item directly
    func deleteItem(_ item: FoodItem, from database: NSManagedObjectContext) {
        database.delete(item)
        try? database.save()

    }
    
    //Create a storage in the database
    func createStorage(name: String, iconName: String, in database: NSManagedObjectContext) {
        let newStorage = FoodStorage(context: database)
        newStorage.name = name
        newStorage.items = []
        newStorage.iconName = iconName
        newStorage.id = UUID()
        
        try? database.save()

    }
    
    // Delete storage function
    func deleteStorage(_ storage: FoodStorage, from database: NSManagedObjectContext) {
        database.delete(storage)
        try? database.save()

    }
}


