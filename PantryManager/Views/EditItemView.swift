//
//  EditItemView.swift
//  PantryManager
//
//  Created by Davide Andreoli on 14/04/21.
//

import SwiftUI
import Combine

struct EditItemView: View {
    // MARK: TO DO - This needs to be fixed as it's currently not working

    // View Model
    @StateObject var foodItemViewModel: FoodItemViewModel
    // Others
    let numberFormatter = NumberFormatter.defaultFormatter
    // Environment variables
    @Environment(\.editMode) var editMode
    @Environment(\.managedObjectContext) private var database
    
    var body: some View {
        Form {
            Section(header: Text("Name")) {
                TextField("", text: $foodItemViewModel.draft.name)
            }

            Section(header: Text("Quantity")) {

                TextField("Item quantity", value: $foodItemViewModel.draft.quantity, formatter: numberFormatter)
                        .keyboardType(.numberPad)
                // MARK: TO DO - Fix the quantity stepper
/*
                Stepper(value: $quantity, in: 1...50) {
                    TextField("Item quantity", value: $quantity, formatter: NumberFormatter())
                        .keyboardType(.numberPad)
                }
                 */
                Picker(selection: $foodItemViewModel.draft.quantityUnit, label: Text("What is the unit?")) {
                    ForEach(FoodItemStruct.quantityUnits.sorted(by: { $0.1 < $1.1 }), id:\.key) { key, value in
                        Text(value)
                    }
                }
            }
            

            Section(header: Text("Expiry Date")) {
                DatePicker("Expiry Date", selection: $foodItemViewModel.draft.expiryDate, displayedComponents: [.date])
                
            }

        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button("Done") {
                    foodItemViewModel.modifyItem()
                     editMode?.animation().wrappedValue = .inactive
                 }
                .disabled(foodItemViewModel.draft.cannotBeSaved)
            }
            ToolbarItemGroup(placement: .navigationBarLeading) {
                Button("Cancel") {
                    editMode?.animation().wrappedValue = .inactive
                 }
            }
        }
    }
}

/*
struct EditItemView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleData = FoodItemStruct(from: FoodItem(name: "Eggs", expiryDate: Date()))
        EditItemView(item: .constant(sampleData))
    }
}
*/
