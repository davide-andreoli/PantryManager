//
//  ItemListView.swift
//  PantryManager
//
//  Created by Davide Andreoli on 15/04/21.
//

import SwiftUI
import CoreData
import Combine

struct ItemListView: View {
    // State variables
    @State var itemsStorage: FoodStorage
    @State private var showingAddItemView: Bool = false
    // View model
    @ObservedObject var viewModel: PantryManagerViewModel
    // Environment variables
    @Environment(\.managedObjectContext) private var database
    //    MARK: TO DO - understand if it's better to refetch te results from the items of the given storage instead of passing the storage directly
    // Fetch request to fecth all items from database
    @FetchRequest var items: FetchedResults<FoodItem>
    init(itemsStorage: FoodStorage, viewModel: PantryManagerViewModel) {
        _itemsStorage = State(wrappedValue: itemsStorage)
        _viewModel = ObservedObject(wrappedValue: viewModel)
        let request = NSFetchRequest<FoodItem>(entityName: "FoodItem")
        request.sortDescriptors = [NSSortDescriptor(key: "name_", ascending: true)]
        request.predicate = NSPredicate(format: "storage = %@", itemsStorage)
        _items = FetchRequest(fetchRequest: request)
 
    }
    
    var body: some View {
            List {
                ForEach(itemsStorage.items.sorted()) { item in
                       
                    NavigationLink(destination: ItemView(item: item, viewModel: viewModel)) {
                            Text(item.name)
                        }
                }
                .onDelete { indexSet in
                    indexSet.map { itemsStorage.items.sorted()[$0] }.forEach { item in
                        viewModel.delete(item, from: database)
                    }
                }

            }
                .sheet(isPresented: $showingAddItemView) {
                    AddItemView(itemStorage: itemsStorage, viewModel: viewModel)
                        .environment(\.managedObjectContext, database)
                }
            .navigationTitle(itemsStorage.name)
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
/*
struct ItemListView_Previews: PreviewProvider {
    let database = PersistenceController.preview.container.viewContext

    static var previews: some View {
        ItemListView(itemsStorageOld: "Pantry", itemsStorage: ,viewModel: PantryManagerViewModel())
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
*/
