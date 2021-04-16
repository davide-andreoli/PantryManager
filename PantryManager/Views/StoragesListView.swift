//
//  StoragesListView.swift
//  PantryManager
//
//  Created by Davide Andreoli on 15/04/21.
//

import SwiftUI

struct StoragesListView: View {
    @ObservedObject var viewModel: PantryManagerViewModel
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.storages, id:\.self) {storage in
                    NavigationLink(destination: ItemListView(itemsStorage: storage, viewModel: viewModel)) {
                        Text(storage)
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
