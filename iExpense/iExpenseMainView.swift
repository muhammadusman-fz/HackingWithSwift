//
//  iExpenseMainView.swift
//  HackingWithSwift
//
//  Created by Muhammad Usman on 2/8/2022.
//

import SwiftUI

struct iExpenseMainView: View {
    @StateObject var expenses = Expenses()
    
    @State private var showAddExpense = false
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section {
                        ForEach(expenses.items.filter { $0.type == "Business" }) { expense in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("\(expense.title)")
                                        .font(.headline)
                                    
                                    Text("\(expense.type)")
                                }
                                
                                Spacer()
                                
                                Text(expense.price, format: .currency(code: "USD"))
                                    .font(expense.price >= 100 ? .title3.bold()
                                          : expense.price >= 50 ? .headline : .body
                                    )
                                    .foregroundColor(expense.price >= 100 ? .red : .black)
                            }
                        }
                    } header: {
                        Text("Business")
                    }
                    
                    Section {
                        ForEach(expenses.items.filter { $0.type == "Personal" }) { expense in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("\(expense.title)")
                                        .font(.headline)
                                    
                                    Text("\(expense.type)")
                                }
                                
                                Spacer()
                                
                                Text(expense.price, format: .currency(code: "USD"))
                                    .font(expense.price >= 100 ? .title3.bold()
                                          : expense.price >= 50 ? .headline : .body
                                    )
                                    .foregroundColor(expense.price >= 100 ? .red : .black)
                            }
                        }
                    } header: {
                        Text("Personal")
                    }
                    
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showAddExpense.toggle()
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showAddExpense) {
                AddExpenseItemView(expenses: expenses)
            }
        }
    }
}

struct iExpenseMainView_Previews: PreviewProvider {
    static var previews: some View {
        iExpenseMainView()
    }
}
