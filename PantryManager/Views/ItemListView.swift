//
//  ItemListView.swift
//  PantryManager
//
//  Created by Davide Andreoli on 15/04/21.
//

import SwiftUI
import CoreData
import Combine

@available(iOS 15.0, *)
struct ItemListView: View {
    // State variables
    @State var itemsStorage: FoodStorage?
    @State private var showingAddItemView: Bool = false
    @State private var showingSortSheet: Bool = false
    @State var refresh: Bool = false
    @State private var sortOrder: ((FoodItem, FoodItem) -> Bool) = { item1, item2 in
        item1.name! < item2.name!
    }
    // View model
    @ObservedObject var viewModel: PantryManagerViewModel
    // Environment variables
    @Environment(\.managedObjectContext) private var database
    // Fetch request to fecth items from database
    @FetchRequest(
        sortDescriptors: [ SortDescriptor(\.name)]
        // predicate: NSPredicate(format: "storage != nil AND storage.name == %@", "Fridge")
    ) var items: FetchedResults<FoodItem>
    /*
    init(itemsStorage: FoodStorage?, viewModel: PantryManagerViewModel) {
        if let itemsStorage = itemsStorage {
            _itemsStorage = State(wrappedValue: itemsStorage)
            _viewModel = ObservedObject(wrappedValue: viewModel)
            let request = NSFetchRequest<FoodItem>(entityName: "FoodItem")
            request.predicate = NSPredicate(format: "storage != nil AND storage.id == %@", itemsStorage.id!.uuidString)
            request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
            _items = FetchRequest(fetchRequest: request)
        } else {
            _viewModel = ObservedObject(wrappedValue: viewModel)
            let request = NSFetchRequest<FoodItem>(entityName: "FoodItem")
            request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
            _items = FetchRequest(fetchRequest: request)
        }
 
    }
    */
    var body: some View {
        Group {
            if items.filter(filterStorage).count != 0 {
                List {
                    ForEach(items.sorted(by: sortOrder).filter(filterStorage)) { item in
                           
                        NavigationLink(destination: ItemView(item: item, viewModel: viewModel)) {
                                Text(item.name ?? "No item")
                            }
                    }
                    .onDelete { indexSet in
                        indexSet.map { items[$0] }.forEach { item in
                            viewModel.deleteItem(item, from: database)
                        }
                    }

                }
            } else {
                VStack {
                    Text("It seems like this storage is empty, add an item by clicking the + on the top right.")
                        .padding()
                }
            }
        }
                .sheet(isPresented: $showingAddItemView) {
                    // MARK: TO DO - Send the storage as an optional
                    AddItemView(itemStorage: itemsStorage!, viewModel: viewModel)
                        .environment(\.managedObjectContext, database)
                        .onDisappear {
                            
                        }
                }
                .onAppear{ print(items.count)}
                .actionSheet(isPresented: $showingSortSheet) {
                    ActionSheet(
                        title: Text("Change sort order"),
                        buttons: FoodItem.sortOrders.keys.sorted().map { key in
                                .default(Text(key), action: { changeSortOrder(to: key) })
                        } + [.cancel(Text("Dismiss"))]
                    )}
        /*
                .actionSheet(isPresented: $showingSortSheet) {
                    ActionSheet(
                        title: Text("Change sort order"),
                        buttons: [
                            .default(Text("Name ascending"), action: { changeSortOrder(to: "alphabetical ascending") }),
                            .default(Text("Name descending"), action: { changeSortOrder(to: "alphabetical descending") }),
                            .cancel(Text("Dismiss"))
                        ])
                    }
         */
            .navigationTitle(itemsStorage?.name ?? "All items")
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        Button(action: {
                            showingSortSheet.toggle()
                        }) {
                            Image(systemName: "arrow.up.arrow.down.circle")
                        }
                        Button(action: {
                            showingAddItemView.toggle()
                        }) {
                            Image(systemName: "plus")
                            
                        }
                    }
                }
    }
    func changeSortOrder(to order: String) {
        withAnimation {
            sortOrder = FoodItem.sortOrders[order]!
        }
    }
    func filterStorage(_ item: FoodItem) -> Bool {
        if let itemsStorage = itemsStorage {
            return item.storage!.id == itemsStorage.id
        }
        else {
            return true
        }
    }
}


struct ItemListView_Previews: PreviewProvider {
    
    static let foodStorage = FoodStorage(name: "Storage", items: [FoodItem(name: "EEE"), FoodItem(name: "Item2")])
    
    static var previews: some View {
        let database = PersistenceController.preview.container.viewContext
        ItemListView(itemsStorage: foodStorage, viewModel: PantryManagerViewModel())
            .environment(\.managedObjectContext, database)
    }
}


