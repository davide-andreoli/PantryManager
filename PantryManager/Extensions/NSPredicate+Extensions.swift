//
//  NSPredicate+Extensions.swift
//  PantryManager
//
//  Created by Davide Andreoli on 16/05/21.
//

import Foundation

extension NSPredicate {
    static var all = NSPredicate(format: "TRUEPREDICATE")
    static var none = NSPredicate(format: "FALSEPREDICATE")
}
