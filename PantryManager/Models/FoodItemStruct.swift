//
//  FoodItemStruct.swift
//  PantryManager
//
//  Created by Davide Andreoli on 30/11/22.
//

import SwiftUI

struct FoodItemStruct: Identifiable, Hashable {
    
        // the id will be the same as the id of any corresponding Item that
        // backs this data in Core Data (so we can find it later)
    let id: UUID
    
        // generic fields copied from Item objects in core data
    var name: String
    var quantity: Double
    var quantityUnit: String
    var expiryDate: Date
    
        // fields copied from the Item's associated Location, including
        // the location's UUID, so we can find that Location later
    var storageID: UUID
    var storageName: String
    var storageIconName: String
    
    init(from item: FoodItem) {
        id = item.id!
        name = item.name!
        quantity = item.quantity
        quantityUnit = item.quantityUnit ?? "Cans"
        expiryDate = item.expiryDate!
            // fields copied from the Item's associated Location
        let foodStorage = item.storage!
        storageID = foodStorage.id!
        storageName = foodStorage.name!
        storageIconName = foodStorage.iconName!
        
    }
    
    init(name: String, quantity: Double, quantityUnit: String, expiryDate: Date) {
        self.id = UUID()
        self.name = name
        self.quantity = quantity
        self.quantityUnit = quantityUnit
        self.expiryDate = expiryDate
        self.storageID = UUID()
        self.storageName = ""
        self.storageIconName = ""
    }
    
    static let empty = FoodItemStruct(name:"",quantity: 1.0, quantityUnit: FoodItemStruct.quantityUnits.first!.value, expiryDate: Date())
    
    var cannotBeSaved: Bool {
        return name.isEmpty || quantity <= 0 || quantityUnit.isEmpty
    }
    
    static let sortOrders: [String : (FoodItemStruct, FoodItemStruct) -> Bool] = [
        "Alphabetical ascending" : { item1, item2 in item1.name < item2.name},
        "Alphabetical descending" : { item1, item2 in item1.name > item2.name},
        "Expiry date ascending" : { item1, item2 in item1.expiryDate < item2.expiryDate},
        "Expiry date descending" : { item1, item2 in item1.expiryDate > item2.expiryDate}
    ]
    
    // MARK: TO DO - Make this a dictionary of UUID : String, so that it will be possible for people to add custom units with the same name as existing units and still be able to delete them. The idea is: A new unit is added to the customUnit array, and deleted from it, checking by ID instead of value.
 
    static let defaultUnits: [String : String] = [UUID().uuidString : "Cans", UUID().uuidString: "Bottles"]
    static var customUnits: [String : String] = [:]
    static var quantityUnits: [String : String] = defaultUnits.merging(customUnits, uniquingKeysWith: +)
    


}
