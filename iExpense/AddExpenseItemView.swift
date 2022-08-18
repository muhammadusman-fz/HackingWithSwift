//
//  AddExpenseItemView.swift
//  HackingWithSwift
//
//  Created by Muhammad Usman on 2/8/2022.
//

import SwiftUI

struct AddExpenseItemView: View {
    @ObservedObject var expenses: Expenses
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    
    let types = ["Business", "Personal"]
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) { type in
                        Text("\(type)")
                    }
                }
                
                TextField("Amount", value: $amount,
                          format: .currency(code: Locale.current.currencyCode ?? "USD"))
                .keyboardType(.decimalPad)
            }
            .navigationTitle("Add new expense")
            .toolbar {
                Button("Save") {
                    let item = ExpenseItem(title: name, type: type, price: amount)
                    expenses.items.insert(item, at: 0)
                    dismiss()
                }
            }
        }
    }
}

struct AddExpenseItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddExpenseItemView(expenses: Expenses())
    }
}
