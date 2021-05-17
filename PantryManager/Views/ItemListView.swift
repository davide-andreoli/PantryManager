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
    @Environment(\.managedObjectContext) private var database

    @State var itemsStorageOld: String
    @State var itemsStorage: FoodStorage
    @ObservedObject var viewModel: PantryManagerViewModel
    @State private var showingAddItemView: Bool = false
    //    MARK: TO DO - understand if it's better to refetch te results from the items of the given storage instead of passing the storage directly
    @FetchRequest var items: FetchedResults<FoodItem>
    init(itemsStorageOld: String, itemsStorage: FoodStorage, viewModel: PantryManagerViewModel) {
        _itemsStorageOld = State(wrappedValue: itemsStorageOld)
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
                    indexSet.map( { viewModel.delete(itemsStorage.items.sorted()[$0], from: database)} )
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
    static var previews: some View {
        ItemListView(itemsStorageOld: "Pantry" ,viewModel: PantryManagerViewModel())
    }
}
*/
