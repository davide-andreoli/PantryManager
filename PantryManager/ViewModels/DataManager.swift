//
//  DataManager.swift
//  PantryManager
//
//  Created by Davide Andreoli on 29/11/22.
//

import CoreData
import Foundation
import SwiftUI

class DataManager: NSObject, ObservableObject {
    // our private hook into Core Data
    // private var managedObjectContext: NSManagedObjectContext
    var managedObjectContext: NSManagedObjectContext
    // we use NSFetchedResultsControllers in place of distributed @FetchRequests
    // to keep track of Items and Locations
    private let foodItemsFRC: NSFetchedResultsController<FoodItem>
    private let foodStorageFRC: NSFetchedResultsController<FoodStorage>
    
    private var foodItems = [FoodItem]()
    @Published var foodItemStructs = [FoodItemStruct]()

    private var foodStorages = [FoodStorage]()
    @Published var foodStoragesStructs = [FoodStorageStruct]()
    
    override init() {
            // set up Core Data (we own it)
        let persistentStore = PersistentStore()
        managedObjectContext = persistentStore.context
        
            // create NSFetchedResultsControllers here for Items and Locations
        let foodItemFetchRequest: NSFetchRequest<FoodItem> = FoodItem.fetchRequest()
        foodItemFetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        foodItemsFRC = NSFetchedResultsController(fetchRequest: foodItemFetchRequest,
                                                             managedObjectContext: managedObjectContext,
                                                             sectionNameKeyPath: nil, cacheName: nil)
        
        let foodStorageFetchRequest: NSFetchRequest<FoodStorage> = FoodStorage.fetchRequest()
        foodStorageFetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        foodStorageFRC = NSFetchedResultsController(fetchRequest: foodStorageFetchRequest,
                                                             managedObjectContext: managedObjectContext,
                                                             sectionNameKeyPath: nil, cacheName: nil)
    
            // finish our initialization as an NSObject
        super.init()
        
            // hook ourself in as the delegate of each of these FRCs and do a first fetch to populate
            // the two @Published arrays we vend
        foodItemsFRC.delegate = self
        try? foodItemsFRC.performFetch()
        self.foodItems = foodItemsFRC.fetchedObjects ?? []
        
        foodStorageFRC.delegate = self
        try? foodStorageFRC.performFetch()
        self.foodStorages = foodStorageFRC.fetchedObjects ?? []
        
        updateUIStructs()
    }
    func saveData() {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch let error as NSError {
                NSLog("Unresolved error saving context: \(error), \(error.userInfo)")
            }
        }
    }
    
    func updateUIStructs() {
        foodItemStructs = foodItems.map { FoodItemStruct(from: $0) }
        foodStoragesStructs = foodStorages.map { FoodStorageStruct(from: $0) }
    }
    
    func foodItem(withID id: UUID) -> FoodItem? {
        FoodItem.object(id: id, context: managedObjectContext)
    }
    
    func foodStorage(withID id: UUID) -> FoodStorage? {
        FoodStorage.object(id: id, context: managedObjectContext)
    }
    
    func updateData(using draft: FoodItemStruct) {
        // first get the location associated with this draft.  if we can't find one, it's
        // not exactly clear what we're doing

    }
    
    func addNewItem(using draft: FoodItemStruct) {
        let newFoodItem = FoodItem(context: managedObjectContext)
        newFoodItem.name = draft.name
        newFoodItem.quantity = draft.quantity
        newFoodItem.quantityUnit = draft.quantityUnit
        newFoodItem.expiryDate = draft.expiryDate
        newFoodItem.id = UUID()
        newFoodItem.storage = FoodStorage.object(id: draft.storageID, context: managedObjectContext)
    }
    
    func modifyItem(using draft: FoodItemStruct) {
        if let foodItem = FoodItem.object(id: draft.id, context: managedObjectContext) {
            foodItem.name = draft.name
            foodItem.quantity = draft.quantity
            foodItem.quantityUnit = draft.quantityUnit
            foodItem.expiryDate = draft.expiryDate
        } else {
            
        }

    }
    
    func deleteItem(using draft: FoodItemStruct) {
        if let foodItem = FoodItem.object(id: draft.id, context: managedObjectContext) {
            managedObjectContext.delete(foodItem)
        } else {
            
        }

    }
    
    func addNewItem(using draft: FoodStorageStruct) {
        let newFoodStorage = FoodStorage(context: managedObjectContext)
        newFoodStorage.name = draft.name
        newFoodStorage.iconName = draft.iconName
        newFoodStorage.id = UUID()
        newFoodStorage.items = []
    }
    
    func nuke() {
        var fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "FoodStorage")
        var deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        try! managedObjectContext.execute(deleteRequest)
        fetchRequest = NSFetchRequest(entityName: "FoodItem")
        deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        try! managedObjectContext.execute(deleteRequest)
        try! managedObjectContext.save()
        updateUIStructs()
    }
}

extension DataManager: NSFetchedResultsControllerDelegate {
    
        // we listen for changes to Items and Locations here.
        // it's a simple way to mimic what a @FetchRequest would do in SwiftUI for one of these objects.
        // note: this is most likely the spot where we can identify any cloud latency problem of having
        //created an Unknown Location on device and then finding we already had one in the cloud.
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        if let newFoodItems = controller.fetchedObjects as? [FoodItem] {
            foodItems = newFoodItems
        } else if let newFoodStorages = controller.fetchedObjects as? [FoodStorage] {
            foodStorages = newFoodStorages
        }
        updateUIStructs()
    }


}
