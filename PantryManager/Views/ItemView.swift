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
        formatter.setLocalizedDateFormatFromTemplate("dd/MM/yyyy")
        return formatter
    }()
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    @Environment(\.editMode) var editMode
    @Environment(\.managedObjectContext) private var database

    
    var body: some View {
        if editMode?.wrappedValue == .inactive {
            Form {
                Section(header: Text("Name")) {
                    Text(item.name)
                }
                // quantity to be fixed later
                Section(header: Text("Quantity")) {
                    Text("\(numberFormatter.string(from: item.quantity as NSNumber) ?? "none")")
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
                .navigationViewStyle(StackNavigationViewStyle())
                
            }
            .navigationTitle("Details")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    EditButton()
                }
                //This fixes the back button strangely disappearing
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Text("")
                }
            }
        } else {
            
            EditItemView(item: $item)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        Button("Done") {
                            //    MARK: TO DO - Disable button if one of the fiels is empty
                            try? database.save()
                             editMode?.animation().wrappedValue = .inactive
                         }
                    }
                    ToolbarItemGroup(placement: .navigationBarLeading) {
                        Button("Cancel") {
                            database.rollback()
                            editMode?.animation().wrappedValue = .inactive
                         }
                    }
                }
                .onAppear() {
                    
                }
 
        }

        
    }
    
    func deleteItem(item: FoodItem) {
        viewModel.delete(item, from: database)
        presentationMode.wrappedValue.dismiss()
    }
}
/*
struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleData = LocalFoodItem(name: "Eggs", quantity: 3, quantityType: .unit, expiryDate: Date())
        ItemView(item: sampleData, viewModel: PantryManagerViewModel())
    }
}
*/
