//
//  EditItemView.swift
//  PantryManager
//
//  Created by Davide Andreoli on 14/04/21.
//

import SwiftUI

struct EditItemView: View {
    @Binding var item: FoodItem

    var body: some View {
        Form {
            Section(header: Text("Name")) {
                TextField("", text: $item.name)
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
    }
}

struct EditItemView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleData = FoodItem(name: "Eggs", quantity: 3, quantityType: .unit, expiryDate: Date())
        EditItemView(item: .constant(sampleData))
    }
}
