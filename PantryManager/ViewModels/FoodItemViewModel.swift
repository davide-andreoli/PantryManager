//
//  FoodItemViewModel.swift
//  PantryManager
//
//  Created by Davide Andreoli on 30/11/22.
//

import SwiftUI

class FoodItemViewModel: ObservableObject {
    
    @Published var draft: FoodItemStruct
    
    private weak var dataManager: DataManager?
        
    fileprivate init(foodItemStruct: FoodItemStruct, dataManager: DataManager) {
        draft = foodItemStruct
        self.dataManager = dataManager
    }
    
        // init that sets a location and optionally a name for what will be a new Item.
    
        // to do a save/update using a DraftItem, it must have a non-empty name
    var canBeSaved: Bool { draft.name.count > 0 }
    
    private var isDeleted = false
    
    var associatedItem: FoodItem? {
        dataManager?.foodItem(withID: draft.id)
    }
    
    func updateAndSave() {
        if !isDeleted {
            dataManager?.updateData(using: draft)
        }
        dataManager?.saveData()
    }
    
    func addNewItem() {
        dataManager?.addNewItem(using: draft)
        dataManager?.saveData()
    }
    
    func modifyItem() {
        dataManager?.modifyItem(using:draft)
        dataManager?.saveData()
    }
    
    func deleteItem() {
        /*
        guard let item = associatedItem else { return }
        dataManager?.delete(item: item)
        isDeleted = true
         */
    }
    
    
}

extension DataManager {
    
        // the next three functions produce ItemViewModels for item editing views.  the DM is then, essentially,
        // a ItemViewModel factory.  this could change in the future, but i like it for now, just so all the
        // ItemViewModel code generally resides in one place under control of the DM.
    
        // provides a working ItemViewModel from an existing ItemStruct ... it just copies data
        // from the ItemStruct to an ItemViewModel.
    func foodItemViewModel(foodItemStruct: FoodItemStruct) -> FoodItemViewModel {
        FoodItemViewModel(foodItemStruct: foodItemStruct, dataManager: self)
    }
    
    func foodItemViewModel() -> FoodItemViewModel {
        var emptyFoodStruct = FoodItemStruct(name: "", quantity: 1, quantityUnit: "Cans", expiryDate: Date())
        emptyFoodStruct.storageID = UUID()
        emptyFoodStruct.storageName = foodStoragesStructs.first!.name
        emptyFoodStruct.storageIconName = foodStoragesStructs.first!.iconName
        return FoodItemViewModel(foodItemStruct: emptyFoodStruct, dataManager: self)
    }
    

}
