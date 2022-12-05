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
    @State var itemsStorage: FoodStorageStruct?
    @State private var showingAddItemView: Bool = false
    @State private var showingSortSheet: Bool = false
    @State private var sortOrder: ((FoodItemStruct, FoodItemStruct) -> Bool) = { item1, item2 in
        item1.name < item2.name
    }
    // Environment variables
    @EnvironmentObject private var dataManager: DataManager
    // Fetch request to fecth items from database
    var items: [FoodItemStruct] { dataManager.foodItemStructs }
    
    var body: some View {
        Group {
            if items.filter(filterStorage).count != 0 {
                List {
                    ForEach(items.sorted(by: sortOrder).filter(filterStorage), id:\.self) { item in
                        NavigationLink(destination: ItemView(item: item)) {
                                ItemRowView(foodItem: item)
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
                    AddItemView(newItemStorage: itemsStorage, foodItemViewModel: dataManager.foodItemViewModel(foodItemStruct: FoodItemStruct.empty))
                        .onDisappear {
                            
                        }
                }
                .onAppear{ print(items.count)}
                .actionSheet(isPresented: $showingSortSheet) {
                    ActionSheet(
                        title: Text("Change sort order"),
                        buttons: FoodItemStruct.sortOrders.keys.sorted().map { key in
                                .default(Text(key), action: { changeSortOrder(to: key) })
                        } + [.cancel(Text("Dismiss"))]
                    )}
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
            sortOrder = FoodItemStruct.sortOrders[order]!
        }
    }
    func filterStorage(_ item: FoodItemStruct) -> Bool {
        if let itemsStorage = itemsStorage {
            return item.storageID == itemsStorage.id
        }
        else {
            return true
        }
    }
}

/*
struct ItemListView_Previews: PreviewProvider {
    
    
    static let database = PersistenceController.shared.container.viewContext
    
    
    static var previews: some View {
        let foodStorage = FoodStorageStruct(from: FoodStorage(name: "Storage", items: [FoodItem(name: "Eggs"), FoodItem(name: "Items")]))
        ItemListView(itemsStorage: foodStorage)
            .environment(\.managedObjectContext, database)
    }
}
*/

