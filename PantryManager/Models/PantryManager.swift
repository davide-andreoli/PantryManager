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
        let prova1 = FoodItem(name: "Uova", quantity: 3, quantityType: .unit, expiryDate: Date())
        
        pantryItems = [prova1]
        fridgeItems = [prova1]
        freezerItems = [prova1]
    }
}
