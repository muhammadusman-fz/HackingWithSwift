//
//  Expense.swift
//  HackingWithSwift
//
//  Created by Muhammad Usman on 2/8/2022.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let title: String
    let type: String
    let price: Double
}
