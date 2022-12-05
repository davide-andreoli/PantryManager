//
//  ItemView.swift
//  PantryManager
//
//  Created by Davide Andreoli on 14/04/21.
//

import SwiftUI

struct ItemView: View {
    // State variables
    @State var item: FoodItemStruct
    // Others
    let expiryDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("dd/MM/yyyy")
        return formatter
    }()
    let numberFormatter = NumberFormatter.defaultFormatter
    // Environment variables
    @EnvironmentObject private var dataManager: DataManager
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.editMode) var editMode


    
    var body: some View {
        if editMode?.wrappedValue == .inactive {
            Form {
                Section(header: Text("Name")) {
                    Text(item.name)
                }
                // quantity to be fixed later
                Section(header: Text("Quantity")) {
                    Text("\(numberFormatter.string(from: item.quantity as NSNumber) ?? "none") \(item.quantityUnit)")
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
            
            EditItemView(foodItemViewModel: dataManager.foodItemViewModel(foodItemStruct: item))
                

 
        }

        
    }
    
    func deleteItem(item: FoodItemStruct) {
        
        dataManager.deleteItem(using: item)
        presentationMode.wrappedValue.dismiss()
    }
}

/*
 struct ItemView_Previews: PreviewProvider {
 static var previews: some View {
 let sampleData = FoodItemStruct(from: FoodItem(name: "Eggs", expiryDate: Date()))
 ItemView(item: sampleData)
 }
 }
 
 */
