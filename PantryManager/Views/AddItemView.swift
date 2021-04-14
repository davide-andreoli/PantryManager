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
    @State private var itemQuantity: Int = 1
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var pantryViewModel: PantryManagerViewModel
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Name")) {
                    TextField("Item name", text: $itemName)
                }
                Section(header: Text("Quantity")) {
                    Stepper(value: $itemQuantity, in: 1...Int.max) {
                        TextField("Item quantity", value: $itemQuantity, formatter: NumberFormatter())
                            .keyboardType(.numberPad)
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
