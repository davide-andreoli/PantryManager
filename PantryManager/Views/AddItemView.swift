//
//  AddItemView.swift
//  PantryManager
//
//  Created by Davide Andreoli on 14/04/21.
//

import SwiftUI
import Combine

struct AddItemView: View {
    
    @State private var itemName: String = ""
    @State private var itemQuantity: String = "1"
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var pantryViewModel: PantryManagerViewModel
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Name")) {
                    TextField("Item name", text: $itemName)
                }
                Section(header: Text("Quantity")) {
//                    MARK - TO DO: Prevent Stepper from going to zero
                    Stepper(onIncrement: {
                        itemQuantity = String(Int(itemQuantity)! + 1)
                        print("Increment: \(itemQuantity)")
                    }, onDecrement: {
                            itemQuantity = String(Int(itemQuantity)! - 1)
                    }) {
                        TextField("Item quantity", text: $itemQuantity)
                            .keyboardType(.numberPad)
                            .onReceive(Just(itemQuantity)) { newValue in
                                let filteredValue = newValue.filter {
                                    "0123456789".contains($0)
                                }
                                if filteredValue != newValue {
                                    itemQuantity = filteredValue
                                }
                            }
                    }
                }
            }
            .navigationTitle("Add Item")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: {
                        
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
        AddItemView(pantryViewModel: PantryManagerViewModel())
    }
}
