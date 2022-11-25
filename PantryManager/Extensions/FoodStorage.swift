//
//  FoodStorage.swift
//  PantryManager
//
//  Created by Davide Andreoli on 16/05/21.
//

import Foundation
import CoreData
import Combine

// Since these properties will never be nil, this will make it easier to use them in the code
extension FoodStorage {

}

//Functions
extension FoodStorage {
    //Convenience function to generate a fetch request with the given predicate
    static func fetchRequest(_ predicate: NSPredicate) -> NSFetchRequest<FoodStorage> {
        let request = NSFetchRequest<FoodStorage>(entityName: "FoodStorage")
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        request.predicate = predicate
        return request
    }
}

// Make two FoodStorages comparable by comparing their names
extension FoodStorage: Comparable {
    public static func < (lhs: FoodStorage, rhs: FoodStorage) -> Bool {
        return lhs.name! < rhs.name!
    }
}

extension FoodStorage {
    convenience init(name: String, items: Set<FoodItem> = Set<FoodItem>(), id: UUID = UUID()) {
        self.init(context: PersistenceController.shared.container.viewContext)
        self.name = name
        self.items = items as NSSet
        self.id = id
    }
    
    static let sortOrders: [String : (FoodStorage, FoodStorage) -> Bool] = [
        "Alphabetical ascending" : { storage1, storage2 in storage1.name! < storage2.name!},
        "Alphabetical descending" : { storage1, storage2 in storage1.name! > storage2.name!}
    ]
}

