//
//  CreateStorageView.swift
//  PantryManager
//
//  Created by Davide Andreoli on 03/04/22.
//

import SwiftUI

struct CreateStorageView: View {
    @State private var newStorageName: String = ""
    @ObservedObject var viewModel: PantryManagerViewModel
    //Environment variables
    @Environment(\.managedObjectContext) private var database
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Storage name")) {
                    TextField("Storage name", text: $newStorageName)
                }
               
            }
            .navigationTitle("Add Storage")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: {
                        viewModel.createStorage(name: newStorageName, in: database)
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Add")
                    }
                    .disabled(newStorageName.isEmpty)
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

struct CreateStorageView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CreateStorageView(viewModel: PantryManagerViewModel())
        }
    }
}
