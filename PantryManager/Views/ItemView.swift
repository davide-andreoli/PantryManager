//
//  ItemView.swift
//  PantryManager
//
//  Created by Davide Andreoli on 14/04/21.
//

import SwiftUI

struct ItemView: View {
    // State variables
    @State var item: FoodItem
    // Others
    let expiryDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("dd/MM/yyyy")
        return formatter
    }()
    let numberFormatter = NumberFormatter.defaultFormatter
    // View model
    @ObservedObject var viewModel: PantryManagerViewModel
    // Environment variables
    @Environment(\.presentationMode) var presentationMode
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
                    Text("\(numberFormatter.string(from: item.quantity as NSNumber) ?? "none") \(item.quantityUnit.rawValue)")
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
                

 
        }

        
    }
    
    func deleteItem(item: FoodItem) {
        viewModel.deleteItem(item, from: database)
        presentationMode.wrappedValue.dismiss()
    }
}

struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleData = FoodItem(name: "Eggs", expiryDate: Date())
        ItemView(item: sampleData, viewModel: PantryManagerViewModel())
    }
}

