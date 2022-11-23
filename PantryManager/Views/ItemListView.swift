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
    @State var itemsStorage: FoodStorage?
    @State private var showingAddItemView: Bool = false
    // View model
    @ObservedObject var viewModel: PantryManagerViewModel
    // Environment variables
    @Environment(\.managedObjectContext) private var database
    // Fetch request to fecth items from database
    @FetchRequest var items: FetchedResults<FoodItem>
    init(itemsStorage: FoodStorage?, viewModel: PantryManagerViewModel) {
        if let itemsStorage = itemsStorage {
            _itemsStorage = State(wrappedValue: itemsStorage)
            _viewModel = ObservedObject(wrappedValue: viewModel)
            let request = NSFetchRequest<FoodItem>(entityName: "FoodItem")
            request.predicate = NSPredicate(format: "storage != nil AND storage.name_ == %@", itemsStorage.name)
            request.sortDescriptors = [NSSortDescriptor(key: "name_", ascending: true)]
            _items = FetchRequest(fetchRequest: request)
        } else {
            _viewModel = ObservedObject(wrappedValue: viewModel)
            let request = NSFetchRequest<FoodItem>(entityName: "FoodItem")
            request.sortDescriptors = [NSSortDescriptor(key: "name_", ascending: true)]
            _items = FetchRequest(fetchRequest: request)
        }
 
    }
    
    var body: some View {
            List {
                ForEach(items) { item in
                       
                    NavigationLink(destination: ItemView(item: item, viewModel: viewModel)) {
                            Text(item.name)
                        
                        }
                }
                .onDelete { indexSet in
                    indexSet.map { items[$0] }.forEach { item in
                        viewModel.deleteItem(item, from: database)
                    }
                }

            }
                .sheet(isPresented: $showingAddItemView) {
                    // MARK: TO DO - Send the storage as an optional
                    AddItemView(itemStorage: itemsStorage!, viewModel: viewModel)
                        .environment(\.managedObjectContext, database)
                }
            .navigationTitle(itemsStorage?.name ?? "Title")
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
    let database = PersistenceController.preview.container.viewContext
    static let foodStorage = FoodStorage(name: "Storage", items: [FoodItem(name: "Item1"), FoodItem(name: "Item2")])
    
    

    static var previews: some View {
        ItemListView(itemsStorage: foodStorage, viewModel: PantryManagerViewModel())
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

