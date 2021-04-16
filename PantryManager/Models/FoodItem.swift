//
//  FoodItem.swift
//  PantryManager
//
//  Created by Davide Andreoli on 13/04/21.
//

import Foundation

struct FoodItem: Identifiable {
    // Name of the item
    var name: String
    // Quantity
    var quantity: Int
    // TDB - Still to be implemented and used
    var quantityType: QuantityType
    // Location of the item
    var storage: String = "Pantry"
    // Expiry Date
    var expiryDate: Date
    // ID
    var id: UUID = UUID()
    
    enum QuantityType: String {
        case unit = "units"
        case bottles = "bottles"
    }
    
}
