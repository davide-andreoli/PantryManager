//
//  Array+Extensions.swift
//  PantryManager
//
//  Created by Davide Andreoli on 16/04/21.
//

import Foundation

extension Array where Element: Identifiable {
    // Return the first index that matches the ID of the elemen given to the function
    func firstIndex(matching element: Element) -> Self.Index? {
        firstIndex(where: { $0.id == element.id })
    }
}
