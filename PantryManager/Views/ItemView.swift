//
//  ItemView.swift
//  PantryManager
//
//  Created by Davide Andreoli on 14/04/21.
//

import SwiftUI

struct ItemView: View {
    var item: FoodItem
    
    var body: some View {
        Form {
            Section(header: Text("Name")) {
                Text(item.name)
            }
            Section(header: Text("Quantity")) {
                Text("\(item.quantity)")
            }
            
        }
        
    }
}

struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        let prova1 = FoodItem(name: "Uova", quantity: 3, quantityType: .unit, expiryDate: Date())
        ItemView(item: prova1)
    }
}
