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
    public var id: UUID {
        get {
            id_ ?? UUID()
        }
        set {
            id_ = newValue
        }
    }
    
    var name: String {
        get {
            name_ ?? "Unknown name"
        }
        set {
            name_ = newValue
        }
    }
    var expiryDate: Date {
        get {
            expiryDate_ ?? Date()
        }
        set {
            expiryDate_ = newValue
        }
    }
    
    var quantityUnit: FoodItemQuantityUnit {
        get {
            FoodItemQuantityUnit(rawValue: quantityUnit_ ?? "cans") ?? FoodItemQuantityUnit.cans
        }
        set {
            quantityUnit_ = newValue.rawValue
        }
    }
    

    
    

    

}

// Make two food items comparable by comparing their expiry date
extension FoodItem: Comparable {
    public static func < (lhs: FoodItem, rhs: FoodItem) -> Bool {
        return lhs.expiryDate < rhs.expiryDate
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
}
