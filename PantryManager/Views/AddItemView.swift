//
//  AddItemView.swift
//  PantryManager
//
//  Created by Davide Andreoli on 14/04/21.
//

import SwiftUI
import Combine

struct AddItemView: View {
    // State variables
    @State var newItemStorage: FoodStorageStruct?
    // Others
    let numberFormatter = NumberFormatter.defaultFormatter
    var storages: [FoodStorageStruct] { dataManager.foodStoragesStructs }
    // View Model
    @StateObject var foodItemViewModel: FoodItemViewModel
    //Environment variables
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject private var dataManager: DataManager


    
//    MARK: UI/UX - Is it better to delete the sections?
    
    var body: some View {
        NavigationView {
            Form {
                    Section(header: Text("Storage")) {

                        Picker(selection: $foodItemViewModel.draft.storageID, label: Text("Storage")) {
                            ForEach(storages, id:\.self) { storage in
                                Text(storage.name).tag(storage.id)
                            }
                        }
                        .onAppear {
                            foodItemViewModel.draft.storageID = storages.first!.id
                        }
                    }

                Section(header: Text("Name")) {
                    TextField("Item name", text: $foodItemViewModel.draft.name)
                }
                Section(header: Text("Quantity")) {
                    StepperField(stepperValue: $foodItemViewModel.draft.quantity)
                    //DoubleField("Item quantity", value: $foodItemViewModel.draft.quantity, formatter: numberFormatter)
                    //TextField("Item quantity", text: $foodItemViewModel.draft.quantity)
                    Picker(selection: $foodItemViewModel.draft.quantityUnit, label: Text("What is the unit?")) {
                        ForEach(FoodItemStruct.quantityUnits.sorted(by: { $0.1 < $1.1 }), id:\.key) { key, value in
                            Text(value).tag(value)
                        }
                    }

                }
                Section(header: Text("Expiry Date")) {
                    DatePicker("Expiry Date", selection: $foodItemViewModel.draft.expiryDate, displayedComponents: [.date])
                }
            }
            .navigationTitle("Add item to " + (newItemStorage?.name ?? "a storage"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: {
                        foodItemViewModel.addNewItem()
                       // viewModel.addItem(name: newItemName, expiryDate: newItemExpiryDate, quantity: newItemQuantity, quantityUnit: newItemQuantityUnit, storage: newItemStorage!, in: database)
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Add")
                    }
                    .disabled(foodItemViewModel.draft.cannotBeSaved)
                }
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Cancel")
                    }
                }

            }
        }
    }
}

/*

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        let foodStorage = FoodStorageStruct(from: FoodStorage(name: "Storage"))
        AddItemView(newItemStorage: foodStorage, viewModel: PantryManagerViewModel())
    }
}
*/
