//
//  ItemListView.swift
//  PantryManager
//
//  Created by Davide Andreoli on 15/04/21.
//

import SwiftUI

struct ItemListView: View {
    @State var itemsStorage: String
    @ObservedObject var viewModel: PantryManagerViewModel
    @State private var showingAddItemView: Bool = false
    
    var body: some View {
            List {
                ForEach(viewModel.items.filter { $0.storage == itemsStorage }) { item in
                        NavigationLink(destination: ItemView(item: item, viewModel: viewModel)) {
                            Text(item.name)
                        }
                }
                .onDelete(perform: {
                    viewModel.delete(at: $0, from: itemsStorage)
                })
            }
                .sheet(isPresented: $showingAddItemView) {
                    AddItemView(itemStorage: itemsStorage, viewModel: viewModel)
                }
                .navigationTitle(itemsStorage)
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        Button(action: {
                            showingAddItemView.toggle()
                        }) {
                            Image(systemName: "plus")
                        }
                    }
                }
    }
}

struct ItemListView_Previews: PreviewProvider {
    static var previews: some View {
        ItemListView(itemsStorage: "Pantry" ,viewModel: PantryManagerViewModel())
    }
}
