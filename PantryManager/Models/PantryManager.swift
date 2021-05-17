//
//  PantryManager.swift
//  PantryManager
//
//  Created by Davide Andreoli on 14/04/21.
//

import Foundation

struct PantryManager {

    // Array containing all food items 
    var items: [LocalFoodItem]
    // Array containing all storages
    var storages: [String] = ["Pantry", "Freezer", "Fridge"]
    
    init() {
        
        let sampleData = [
            LocalFoodItem(name: "Eggs", quantity: 3, quantityType: .unit, expiryDate: Date()),
            LocalFoodItem(name: "Milk", quantity: 3, quantityType: .bottles, expiryDate: Date()),
            LocalFoodItem(name: "Meat", quantity: 3, quantityType: .bottles, storage: "Fridge", expiryDate: Date()),
            LocalFoodItem(name: "Ice Cream", quantity: 3, quantityType: .bottles, storage: "Freezer", expiryDate: Date()),
            LocalFoodItem(name: "Pie", quantity: 3, quantityType: .bottles, storage: "Pantry", expiryDate: Date())
        ]
        
        items = sampleData
    }
}
