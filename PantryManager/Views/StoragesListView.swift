//
//  StoragesListView.swift
//  PantryManager
//
//  Created by Davide Andreoli on 15/04/21.
//

import SwiftUI

struct StoragesListView: View {
    @ObservedObject var viewModel: PantryManagerViewModel
    @FetchRequest(fetchRequest: FoodStorage.fetchRequest(.all)) var storages
    var body: some View {
        NavigationView {
            List {
                ForEach(storages.sorted(), id:\.self) {storage in
                    NavigationLink(destination: ItemListView(itemsStorageOld: storage.name, itemsStorage: storage, viewModel: viewModel)) {
                        Text(storage.name)
                    }
                }
            }
            .navigationTitle("Storages")
        }
    }
}

struct StoragesListView_Previews: PreviewProvider {
    static var previews: some View {
        StoragesListView(viewModel: PantryManagerViewModel())
    }
}
