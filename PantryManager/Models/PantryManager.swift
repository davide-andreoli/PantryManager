//
//  PantryManager.swift
//  PantryManager
//
//  Created by Davide Andreoli on 14/04/21.
//

import Foundation

struct PantryManager {

    // Array containing all food items 
    var items: [FoodItem]
    // Array containing all storages
    var storages: [String] = ["Pantry", "Freezer", "Fridge"]
    
    init() {
        
        let sampleData = [
            FoodItem(name: "Eggs", quantity: 3, quantityType: .unit, expiryDate: Date()),
            FoodItem(name: "Milk", quantity: 3, quantityType: .bottles, expiryDate: Date()),
            FoodItem(name: "Meat", quantity: 3, quantityType: .bottles, storage: "Fridge", expiryDate: Date()),
            FoodItem(name: "Ice Cream", quantity: 3, quantityType: .bottles, storage: "Freezer", expiryDate: Date()),
            FoodItem(name: "Pie", quantity: 3, quantityType: .bottles, storage: "Pantry", expiryDate: Date())
        ]
        
        items = sampleData
    }
}
