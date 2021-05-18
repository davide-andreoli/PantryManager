//
//  NumberFormatter+Extensions.swift
//  PantryManager
//
//  Created by Davide Andreoli on 17/05/21.
//

import Foundation

extension NumberFormatter {
    static var defaultFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesSignificantDigits = true
        return formatter
    }
}
