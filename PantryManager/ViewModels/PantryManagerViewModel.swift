//
//  PantryManagerViewModel.swift
//  PantryManager
//
//  Created by Davide Andreoli on 14/04/21.
//

import Foundation
import SwiftUI

class PantryManagerViewModel: ObservableObject {
    var pantryManagerModel = PantryManager()
    
    var pantryItmes: [FoodItem] {
        return pantryManagerModel.pantryItems
    }
}
