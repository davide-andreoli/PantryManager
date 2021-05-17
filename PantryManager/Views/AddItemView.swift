//
//  AddItemView.swift
//  PantryManager
//
//  Created by Davide Andreoli on 14/04/21.
//

import SwiftUI
import Combine

struct AddItemView: View {
    @Environment(\.managedObjectContext) private var database
    @FetchRequest var storages: FetchedResults<FoodStorage>
    
    @State var itemStorage: FoodStorage
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: PantryManagerViewModel
    @State private var newItemName = ""
    @State private var newItemExpiryDate = Date()
    @State private var newItemQuantity: Int = 1
    
    init(itemStorage: FoodStorage, viewModel: PantryManagerViewModel) {
        _itemStorage = State(wrappedValue: itemStorage)
        _viewModel = ObservedObject(wrappedValue: viewModel)
        _storages = FetchRequest(fetchRequest: FoodStorage.fetchRequest(.all))
 
    }
//    MARK: UI/UX - Is it better to delete the sections?
    
//    MARK: TO DO - Maybe use a FoodItem instead of placeholder variables
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Storage")) {

                    Picker(selection: $itemStorage, label: Text("Storage")) {
                        ForEach(storages.sorted(), id:\.self) { storage in
                            Text(storage.name)
                        }
                    }
                }
                Section(header: Text("Name")) {
                    TextField("Item name", text: $newItemName)
                }
                Section(header: Text("Quantity")) {
                    Stepper(value: $newItemQuantity, in: 1...Int.max) {
                        TextField("Item quantity", value: $newItemQuantity, formatter: NumberFormatter())
                            .keyboardType(.numberPad)
                    }
                }
                Section(header: Text("Expiry Date")) {
                    DatePicker("Expiry Date", selection: $newItemExpiryDate, displayedComponents: [.date])
                    
                }
            }
            .navigationTitle("Add Item")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: {
                        viewModel.create(name: newItemName, expiryDate: newItemExpiryDate, storage: itemStorage, in: database)
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        //    MARK: TO DO - Disable button if one of the fiels is empty
                        Text("Add")
                    }
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
        AddItemView(itemStorageOld: "Pantry", viewModel: PantryManagerViewModel())
    }
}
*/
