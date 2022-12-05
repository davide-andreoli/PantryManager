//
//  CreateStorageView.swift
//  PantryManager
//
//  Created by Davide Andreoli on 03/04/22.
//

import SwiftUI

struct AddStorageView: View {
    @StateObject var foodStorageViewModel: FoodStorageViewModel
    //Environment variables
    @Environment(\.managedObjectContext) private var database
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject private var dataManager: DataManager
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Storage name")) {
                    TextField("Storage name", text: $foodStorageViewModel.draft.name)
                    Picker("Storage icon", selection: $foodStorageViewModel.draft.iconName) {
                        ForEach(FoodStorageStruct.iconNames.sorted(), id:\.self) { value in
                            Image(systemName: value)
                        }
                    }
                }
                
               
            }
            .navigationTitle("Add Storage")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: {
                        foodStorageViewModel.addNewStorage()
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Add")
                    }
                    .disabled(foodStorageViewModel.draft.name.isEmpty)
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
/*
struct AddStorageView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddStorageView(viewModel: PantryManagerViewModel())
        }
    }
}
*/
