//
//  FoodItem.swift
//  PantryManager
//
//  Created by Davide Andreoli on 13/04/21.
//

import Foundation

struct FoodItem: Identifiable {
    var name: String
    var quantity: Int
    var quantityType: QuantityType
    var expiryDate: Date
    var id: UUID = UUID()
    
    enum QuantityType: String {
        case unit = "units"
        case bottles = "bottles"
    }
    
    enum StorageType: String {
        case pantry = "Pantry"
        case fridge = "Fridge"
        case freezer = "Freezer"
    }
}
