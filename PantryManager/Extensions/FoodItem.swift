//
//  FoodItem.swift
//  PantryManager
//
//  Created by Davide Andreoli on 16/05/21.
//

import Foundation
import CoreData
import Combine

// Since these properties will never be nil, this will make it easier to use them in the code
/*
 might be ideal to do it like this
 public var wrappedTitle: String {
     title ?? "Unknown Title"
 }
 */
extension FoodItem {
    
    var quantityUnit: FoodItemQuantityUnit {
        get {
            FoodItemQuantityUnit(rawValue: quantityUnitString ?? "cans") ?? FoodItemQuantityUnit.cans
        }
        set {
            quantityUnitString = newValue.rawValue
        }
    }
    
}

// Make two food items comparable by comparing their expiry date
extension FoodItem: Comparable {
    public static func < (lhs: FoodItem, rhs: FoodItem) -> Bool {
        return lhs.expiryDate! < rhs.expiryDate!
    }
    
    
}

extension FoodItem {
    convenience init(name: String, id: UUID = UUID(), expiryDate: Date = Date()) {
        self.init(context: PersistenceController.shared.container.viewContext)
        self.name = name
        self.id = id
        self.expiryDate = expiryDate
        self.quantity = 1
        self.quantityUnit = FoodItemQuantityUnit.bottles
    }
    
    static let sortOrders: [String : (FoodItem, FoodItem) -> Bool] = [
        "Alphabetical ascending" : { item1, item2 in item1.name! < item2.name!},
        "Alphabetical descending" : { item1, item2 in item1.name! > item2.name!},
        "Expiry date ascending" : { item1, item2 in item1.expiryDate! < item2.expiryDate!},
        "Expiry date descending" : { item1, item2 in item1.expiryDate! > item2.expiryDate!}
    ]
    
}
