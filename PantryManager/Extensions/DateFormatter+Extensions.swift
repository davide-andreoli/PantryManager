//
//  DateFormatter+Extensions.swift
//  PantryManager
//
//  Created by Davide Andreoli on 26/11/22.
//

import Foundation

extension DateFormatter {
    static var defaultFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        return formatter
    }
}
