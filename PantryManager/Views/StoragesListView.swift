//
//  StoragesListView.swift
//  PantryManager
//
//  Created by Davide Andreoli on 15/04/21.
//

import SwiftUI
import CoreData
import Combine

struct StoragesListView: View {
    // State variable
    @State private var showingSortSheet = false
    @State private var showCreateStorageView = false
    @State private var sortOrder: ((FoodStorageStruct, FoodStorageStruct) -> Bool) = { storage1, storage2 in
        storage1.name < storage2.name
    }
    //View Model
    @ObservedObject var viewModel: PantryManagerViewModel
    //Fetch request to fetch storages from database
    @EnvironmentObject private var dataManager: DataManager
    //@FetchRequest(fetchRequest: FoodStorage.fetchRequest(.all)) var storages
    var storages: [FoodStorageStruct] { dataManager.foodStoragesStructs }
    var items: [FoodItemStruct] { dataManager.foodItemStructs }
    
    var body: some View {
        NavigationView {
            VStack {
                if storages.count == 0 {
                    Group {
                        Text("Hey, it seems like you don't have any storage. Start by creating one clicking on the plus in the top right.")
                            .padding(.horizontal)
                    }
                } else {
                    Group {
                        HStack {
                             NavigationLink(destination: ItemListView(itemsStorage: nil)) {
                                 CollectiveButtonView(imageName: "tray.2", count: items.count, title: "All items")
                             }
                             .buttonStyle(PlainButtonStyle())
                             Spacer()
                                 .frame(minWidth: 100)
                         }
                    List {
                        ForEach(storages.sorted(by: sortOrder), id:\.self) {storage in
                                    NavigationLink(destination: ItemListView(itemsStorage: storage)) {
                                        Text(storage.name)
                                    }
                                }
                    }
                    }
                }

            }
            .actionSheet(isPresented: $showingSortSheet) {
                ActionSheet(
                    title: Text("Change sort order"),
                    buttons: FoodStorageStruct.sortOrders.keys.sorted().map { key in
                            .default(Text(key), action: { changeSortOrder(to: key) })
                    } + [.cancel(Text("Dismiss"))]
                )}
            .sheet(isPresented: $showCreateStorageView) {
                AddStorageView(foodStorageViewModel: dataManager.foodStorageViewModel(foodStorageStruct: FoodStorageStruct.empty))
            }
            .navigationTitle("Storages")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingSortSheet.toggle()
                    }) {
                        Image(systemName: "arrow.up.arrow.down.circle")
                    }
                    .disabled(storages.count == 0)
                    Button(action: {
                        showCreateStorageView.toggle()
                    }) {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItemGroup(placement: .navigationBarLeading) {

                }
            }
        }
    }
    
    func changeSortOrder(to order: String) {
        withAnimation {
            sortOrder = FoodStorageStruct.sortOrders[order]!
        }
    }
}

struct StoragesListView_Previews: PreviewProvider {
    static var previews: some View {
        StoragesListView(viewModel: PantryManagerViewModel())
            .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}

