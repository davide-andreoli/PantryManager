//
//  ItemView.swift
//  PantryManager
//
//  Created by Davide Andreoli on 14/04/21.
//

import SwiftUI

struct ItemView: View {
    @State var item: FoodItem
    @ObservedObject var viewModel: PantryManagerViewModel
    @Environment(\.presentationMode) var presentationMode
    let expiryDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()
    @Environment(\.editMode) var editMode
    @State var itemDraft: FoodItem = FoodItem(name: "Eggs", quantity: 3, quantityType: .unit, expiryDate: Date())
    
    var body: some View {
        if editMode?.wrappedValue == .inactive {
            Form {
                Section(header: Text("Name")) {
                    Text(item.name)
                }
                Section(header: Text("Quantity")) {
                    Text(item.quantity == 1 ? "\(item.quantity) unit" : "\(item.quantity) units")
                }
                Section(header: Text("Expiry Date")) {
                    Text("\(item.expiryDate, formatter: expiryDateFormatter)")
                }
                Section {
                    Button(action: {deleteItem(item: item)}) {
                        Text("Delete item")
                    }
                    .foregroundColor(.red)
                    
                }
                
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
        } else {
            EditItemView(item: $itemDraft)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        Button("Done") {
                             item = itemDraft
                             editMode?.animation().wrappedValue = .inactive
                         }
                    }
                    ToolbarItemGroup(placement: .navigationBarLeading) {
                        Button("Cancel") {
                             editMode?.animation().wrappedValue = .inactive
                         }
                    }
                }
                .onAppear() {
                    itemDraft = item
                }
        }

        
    }
    
    func deleteItem(item: FoodItem) {
        viewModel.delete(item)
        presentationMode.wrappedValue.dismiss()
    }
}

struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleData = FoodItem(name: "Eggs", quantity: 3, quantityType: .unit, expiryDate: Date())
        ItemView(item: sampleData, viewModel: PantryManagerViewModel())
    }
}
