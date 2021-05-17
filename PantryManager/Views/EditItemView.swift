//
//  EditItemView.swift
//  PantryManager
//
//  Created by Davide Andreoli on 14/04/21.
//

import SwiftUI
import Combine

struct EditItemView: View {
    @Binding var item: FoodItem
    @State private var quantity = 1.0
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        return formatter
    }()

    var body: some View {
        Form {
            Section(header: Text("Name")) {
                TextField("", text: $item.name)
            }

            Section(header: Text("Quantity")) {

                    TextField("Item quantity", value: $item.quantity, formatter: numberFormatter)
                        .keyboardType(.numberPad)
                // MARK: TO DO - Fix the quantity stepper
/*
                Stepper(value: $quantity, in: 1...50) {
                    TextField("Item quantity", value: $quantity, formatter: NumberFormatter())
                        .keyboardType(.numberPad)
                }
                 */
            }

            Section(header: Text("Expiry Date")) {
                DatePicker("Expiry Date", selection: $item.expiryDate, displayedComponents: [.date])
                
            }

        }
    }
}
/*
struct EditItemView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleData = LocalFoodItem(name: "Eggs", quantity: 3, quantityType: .unit, expiryDate: Date())
        EditItemView(item: .constant(sampleData))
    }
}
*/
