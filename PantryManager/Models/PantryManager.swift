//
//  PantryManager.swift
//  PantryManager
//
//  Created by Davide Andreoli on 14/04/21.
//

import Foundation

struct PantryManager {
    // Old implementation, each storage would have its own var. Scrapped because it's not customizable by the user
    var pantryItems: [FoodItem]
    var fridgeItems: [FoodItem]
    var freezerItems: [FoodItem]
    // Array containing all food items 
    var items: [FoodItem]
    
    var storages: [String] = ["Pantry", "Freezer", "Fridge"]
    
    init() {
        let sampleData = [
            FoodItem(name: "Eggs", quantity: 3, quantityType: .unit, expiryDate: Date()),
            FoodItem(name: "Milk", quantity: 3, quantityType: .bottles, expiryDate: Date()),
        ]
        
        let sampleData2 = [
            FoodItem(name: "Eggs", quantity: 3, quantityType: .unit, expiryDate: Date()),
            FoodItem(name: "Milk", quantity: 3, quantityType: .bottles, expiryDate: Date()),
            FoodItem(name: "Meat", quantity: 3, quantityType: .bottles, storage: "Fridge", expiryDate: Date()),
            FoodItem(name: "Ice Cream", quantity: 3, quantityType: .bottles, storage: "Freezer", expiryDate: Date()),
            FoodItem(name: "Pie", quantity: 3, quantityType: .bottles, storage: "Pantry", expiryDate: Date())
        ]
        
        pantryItems = sampleData
        fridgeItems = sampleData
        freezerItems = sampleData
        items = sampleData2
    }
}
