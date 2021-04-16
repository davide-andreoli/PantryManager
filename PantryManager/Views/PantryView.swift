//
//  ContentView.swift
//  PantryManager
//
//  Created by Davide Andreoli on 13/04/21.
//

import SwiftUI

struct PantryView: View {
    
    @ObservedObject var pantryViewModel: PantryManagerViewModel
    @State private var showingAddItemView: Bool = false
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(pantryViewModel.pantryItmes) { item in
                    NavigationLink(destination: ItemView(item: item)) {
                        Text(item.name)
                    }
                }
                .onDelete(perform: { 
                    pantryViewModel.delete(at: $0, from: "Pantry")
                })
            }
                .padding()
                .navigationTitle("Pantry")
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
        .sheet(isPresented: $showingAddItemView) {
            AddItemView(viewModel: pantryViewModel)
        }
    }
}

struct PantryView_Previews: PreviewProvider {
    static var previews: some View {
        PantryView(pantryViewModel: PantryManagerViewModel())
    }
}
