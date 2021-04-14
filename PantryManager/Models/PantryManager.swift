//
//  PantryManager.swift
//  PantryManager
//
//  Created by Davide Andreoli on 14/04/21.
//

import Foundation

struct PantryManager {
    var pantryItems: [FoodItem]
    var fridgeItems: [FoodItem]
    var freezerItems: [FoodItem]
    
    init() {
        let sampleData = [
            FoodItem(name: "Eggs", quantity: 3, quantityType: .unit, expiryDate: Date()),
            FoodItem(name: "Milk", quantity: 3, quantityType: .bottles, expiryDate: Date()),
        ]
        
        pantryItems = sampleData
        fridgeItems = sampleData
        freezerItems = sampleData
    }
}
