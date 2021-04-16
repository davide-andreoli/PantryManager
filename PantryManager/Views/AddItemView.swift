//
//  AddItemView.swift
//  PantryManager
//
//  Created by Davide Andreoli on 14/04/21.
//

import SwiftUI
import Combine

struct AddItemView: View {
    
    @State var itemStorage: String
    @State private var item: FoodItem = FoodItem(name: "", quantity: 1, quantityType: .unit, expiryDate: Date())
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: PantryManagerViewModel
    
//    MARK: UI/UX - Is it better to delete the sections?
    
//    MARK: TO DO - Detect where the view is being called and set that as the default place
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Storage")) {

                    Picker(selection: $item.storage, label: Text("Storage")) {
                        ForEach(viewModel.storages, id:\.self) { storage in
                            Text(storage)
                        }
                    }
                }
                .onAppear {
                    item.storage = itemStorage
                }
                Section(header: Text("Name")) {
                    TextField("Item name", text: $item.name)
                }
                Section(header: Text("Quantity")) {
                    Stepper(value: $item.quantity, in: 1...Int.max) {
                        TextField("Item quantity", value: $item.quantity, formatter: NumberFormatter())
                            .keyboardType(.numberPad)
                    }
                }
                Section(header: Text("Expiry Date")) {
                    DatePicker("Expiry Date", selection: $item.expiryDate, displayedComponents: [.date])
                    
                }
            }
            .navigationTitle("Add Item")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: {
                        viewModel.add(item)
                        presentationMode.wrappedValue.dismiss()
                    }) {
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

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemView(itemStorage: "Pantry", viewModel: PantryManagerViewModel())
    }
}
