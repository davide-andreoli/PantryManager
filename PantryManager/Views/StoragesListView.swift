//
//  StoragesListView.swift
//  PantryManager
//
//  Created by Davide Andreoli on 15/04/21.
//

import SwiftUI
import CoreData

struct StoragesListView: View {
    // State variable
    @State private var allItemsCount: Int = 0
    @State private var showingSortSheet = false
    @State private var showCreateStorageView = false
    @State private var sortOrder: ((FoodStorage, FoodStorage) -> Bool) = { storage1, storage2 in
        storage1.name < storage2.name
    }
    //View Model
    @ObservedObject var viewModel: PantryManagerViewModel
    //Fetch request to fetch storages from database
    @FetchRequest(fetchRequest: FoodStorage.fetchRequest(.all)) var storages

    
    var body: some View {
        NavigationView {
            VStack {
                    HStack {
                         NavigationLink(destination: ItemListView(itemsStorage: nil, viewModel: viewModel)) {
                             CollectiveButtonView(imageName: "tray.2", count: allItemsCount, title: "All items")
                         }
                         .buttonStyle(PlainButtonStyle())
                         Spacer()
                             .frame(minWidth: 100)
                     }
                List {
                        ForEach(storages.sorted(by: sortOrder), id:\.self) {storage in
                                NavigationLink(destination: ItemListView(itemsStorage: storage, viewModel: viewModel)) {
                                    Text(storage.name)
                                }
                            }
                }
                .actionSheet(isPresented: $showingSortSheet) {
                    ActionSheet(
                        title: Text("Change sort order"),
                        buttons: [
                            .default(Text("Name ascending"), action: { changeSortOrder(to: "alphabetical ascending") }),
                            .default(Text("Name descending"), action: { changeSortOrder(to: "alphabetical descending") }),
                            .cancel(Text("Dismiss"))
                        ])
                    }
                .sheet(isPresented: $showCreateStorageView) {
                    CreateStorageView(viewModel: viewModel)
                }
                .navigationTitle("Storages")
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        Button(action: {
                            showingSortSheet.toggle()
                        }) {
                            Image(systemName: "arrow.up.arrow.down.circle")
                        }
                    }
                    ToolbarItemGroup(placement: .navigationBarLeading) {
                        Button(action: {
                            showCreateStorageView.toggle()
                        }) {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
            .onAppear {
                storages.forEach { storage in
                    var itemsCount = 0
                    itemsCount += storage.items.count
                    allItemsCount = itemsCount
                }
            }
        }
    }
    
    func changeSortOrder(to order: String) {
        withAnimation {
            if order == "alphabetical ascending" {
                sortOrder = { storage1, storage2 in
                    storage1.name < storage2.name
                }
            } else if order == "alphabetical descending" {
                sortOrder = { storage1, storage2 in
                    storage1.name > storage2.name
                }
            }
        }
    }
}


// Possible implementation to sort the list with NSSortDescriptors instead of closures
struct ListView: View {
    
    @FetchRequest var storages: FetchedResults<FoodStorage>
    //View Model
    @ObservedObject var viewModel: PantryManagerViewModel
    
    init(sortDescriptors: [NSSortDescriptor], viewModel: PantryManagerViewModel) {
        _viewModel = ObservedObject(wrappedValue: viewModel)
        let request: NSFetchRequest<FoodStorage> = FoodStorage.fetchRequest()
        request.predicate = .all
        request.sortDescriptors = sortDescriptors
        _storages = FetchRequest<FoodStorage>(fetchRequest: request)
    }
    
    var body: some View {
        List {
            ForEach(storages, id:\.self) {storage in
                    NavigationLink(destination: ItemListView(itemsStorage: storage, viewModel: viewModel)) {
                        Text(storage.name)
                    }
                }
            }
        .navigationTitle("Storages")
    }
}


struct StoragesListView_Previews: PreviewProvider {
    static var previews: some View {
        StoragesListView(viewModel: PantryManagerViewModel())
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

