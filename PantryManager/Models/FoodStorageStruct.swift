//
//  FoodStorageStruct.swift
//  PantryManager
//
//  Created by Davide Andreoli on 30/11/22.
//

import SwiftUI

struct FoodStorageStruct: Identifiable, Hashable {
    
    let id: UUID
    var name: String
    var iconName: String
    var items: [FoodItemStruct]
    
    init(name: String, iconName: String, items: [FoodItemStruct] = []) {
        self.id = UUID()
        self.name = name
        self.iconName = iconName
        self.items = items
    }
    
    init(from foodStorage: FoodStorage) {
        
        id = foodStorage.id!
        name = foodStorage.name!
        iconName = foodStorage.iconName!
        if let temp_items = foodStorage.items?.allObjects as! [FoodItem]?
        {
            items = temp_items.map { FoodItemStruct(from: $0) }
        }
        else { items = [] }
    
    }
    
    static let empty = FoodStorageStruct(name: "", iconName: "bag.fill")
    
    
    static let sortOrders: [String : (FoodStorageStruct, FoodStorageStruct) -> Bool] = [
        "Alphabetical ascending" : { storage1, storage2 in storage1.name < storage2.name},
        "Alphabetical descending" : { storage1, storage2 in storage1.name > storage2.name}
    ]
    
    static let iconNames: [String] = ["bag.fill", "flame.fill", "drop.fill", "tray.2.fill", "pawprint.fill", "leaf.fill", "snowflake"]
    
    
    
    
}
