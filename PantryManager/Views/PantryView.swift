//
//  ContentView.swift
//  PantryManager
//
//  Created by Davide Andreoli on 13/04/21.
//

import SwiftUI

struct PantryView: View {
    
    @ObservedObject var pantryViewModel: PantryManagerViewModel
    
    var body: some View {
        NavigationView {
            List(pantryViewModel.pantryItmes) { item in
                NavigationLink(destination: ItemView(item: item)) {
                    Text(item.name)
                }  
            }
                .padding()
                .navigationTitle("Pantry")
        }
    }
}

struct PantryView_Previews: PreviewProvider {
    static var previews: some View {
        PantryView(pantryViewModel: PantryManagerViewModel())
    }
}
