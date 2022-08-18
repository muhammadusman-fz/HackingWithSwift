//
//  iExpensePractice.swift
//  HackingWithSwift
//
//  Created by Muhammad Usman on 2/8/2022.
//

import SwiftUI

/**
 1. Showing the sheet
 2. Dismiss the sheet programatically using Environment property wrapper
 3. Delete items using onDelete form list and ForEach
 4. Use EditButton
 5. Using UserDefaults and @AppStorage property wrapper to store the data
 */
    

struct SecondView: View {
    //2
    @Environment(\.dismiss) var close
    
    var body: some View {
        Button("Dismiss Me") {
            close()
        }
    }
}


struct iExpensePractice: View {
    //1
    @State private var showingSheet = false
    
    @State private var numbers = [Int]()
    @State private var currentNumber = 1
    
    @AppStorage("tapCount") private var tapCount = 0
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Button("Show Sheet") {
                    showingSheet.toggle()
                }
                .sheet(isPresented: $showingSheet) {
                    SecondView()
                }
                
                Button("Tap Count: \(tapCount)") {
                    tapCount += 1
                }
                
                
                List {
                    ForEach(numbers, id: \.self) {
                        Text("Row \($0)")
                    }
                    .onDelete(perform: deleteRow)
                }
                
                Button("Add Number") {
                    numbers.append(currentNumber)
                    currentNumber += 1
                }
            }
            .navigationTitle("iExpense")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                EditButton()
            }
            
        }
    }
    
    func deleteRow(at offSet: IndexSet) {
        numbers.remove(atOffsets: offSet)
    }
}

struct iExpensePractice_Previews: PreviewProvider {
    static var previews: some View {
        iExpensePractice()
    }
}
