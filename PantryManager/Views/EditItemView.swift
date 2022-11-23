//
//  EditItemView.swift
//  PantryManager
//
//  Created by Davide Andreoli on 14/04/21.
//

import SwiftUI
import Combine

struct EditItemView: View {
    // State variables
    @State private var newItemQuantity: Double = 1
    @State private var newExpiryDate: Date = Date()
    @State private var newName: String = ""
    @State private var newItemQuantityUnit: FoodItemQuantityUnit = .boxess
    // Bindings
    @Binding var item: FoodItem
    // Others
    let numberFormatter = NumberFormatter.defaultFormatter
    // Environment variables
    @Environment(\.editMode) var editMode
    @Environment(\.managedObjectContext) private var database
    
    var body: some View {
        Form {
            Section(header: Text("Name")) {
                TextField("", text: $newName)
            }

            Section(header: Text("Quantity")) {

                DoubleField("Item quantity", value: $newItemQuantity, formatter: numberFormatter)
                        .keyboardType(.numberPad)
                // MARK: TO DO - Fix the quantity stepper
/*
                Stepper(value: $quantity, in: 1...50) {
                    TextField("Item quantity", value: $quantity, formatter: NumberFormatter())
                        .keyboardType(.numberPad)
                }
                 */
                Picker(selection: $newItemQuantityUnit, label: Text("Quantity unit")) {
                    ForEach(FoodItemQuantityUnit.allCases.sorted(by: {$0.rawValue < $1.rawValue}), id:\.rawValue) { unitCase in
                        Text(unitCase.rawValue).tag(unitCase)
                    }
                }
            }
            

            Section(header: Text("Expiry Date")) {
                DatePicker("Expiry Date", selection: $newExpiryDate, displayedComponents: [.date])
                
            }

        }
        .onAppear {
            // MARK: TO DO - maybe do this on an init
            newItemQuantity = item.quantity
            newExpiryDate = item.expiryDate
            newName = item.name
            newItemQuantityUnit = item.quantityUnit
            
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button("Done") {
                    item.quantity = newItemQuantity
                    item.quantityUnit = newItemQuantityUnit
                    item.expiryDate = newExpiryDate
                    item.name = newName
                    try? database.save()
                     editMode?.animation().wrappedValue = .inactive
                 }
                .disabled(newName.isEmpty || newItemQuantity.isZero)
            }
            ToolbarItemGroup(placement: .navigationBarLeading) {
                Button("Cancel") {
                    editMode?.animation().wrappedValue = .inactive
                 }
            }
        }
    }
}

struct EditItemView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleData = FoodItem(name: "Eggs", expiryDate: Date())
        EditItemView(item: .constant(sampleData))
    }
}

