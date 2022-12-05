//
//  ItemRowView.swift
//  PantryManager
//
//  Created by Davide Andreoli on 26/11/22.
//

import SwiftUI

struct ItemRowView: View {
    @State var foodItem: FoodItemStruct
    let dateFormatter: DateFormatter = DateFormatter.defaultFormatter
    var body: some View {
        HStack {
            Image(systemName: foodItem.storageIconName)
            Text(foodItem.name)
            Spacer()
            Text("Expiry date: \(foodItem.expiryDate, formatter: dateFormatter)").font(.footnote)
        }
        .padding(.horizontal)
    }
}

struct ItemRowView_Previews: PreviewProvider {
    static var previews: some View {
        List{
            ItemRowView(foodItem: FoodItemStruct(name: "Eggs", quantity: 22, quantityUnit: "Cans", expiryDate: Date()))
            ItemRowView(foodItem: FoodItemStruct(name: "Eggs", quantity: 22, quantityUnit: "Cans", expiryDate: Date()))
        }
    }
}
