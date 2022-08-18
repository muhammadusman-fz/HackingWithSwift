//
//  EdutainmentLaunchScreen.swift
//  HackingWithSwift
//
//  Created by Muhammad Usman on 2/8/2022.
//

import SwiftUI

struct EdutainmentLaunchScreen: View {
    @State private var tableOf = 5
    var updatedTableOf: Int {
         return tableOf + 2
    }
    
    @State private var questionsLimit = 5
    let questions = [5, 10, 15, 20]
    
    @State private var animationAmount = 1.0
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.mint.ignoresSafeArea()
                
                VStack {
                    HStack {
                        Text("Select the table")
                            .font(.headline)
                        
                        Picker("Select the table", selection: $tableOf) {
                            ForEach(2 ..< 11) {
                                Text("\($0)")
                            }
                        }
                    }
                    
                    HStack {
                        Text("Number of questions")
                            .font(.headline)
                        
                        Picker("Number of questions", selection: $questionsLimit) {
                            ForEach(questions, id: \.self) {
                                Text("\($0)")
                            }
                        }
                    }
                    
                    Spacer()
                    
                    NavigationLink(destination: EdutainmentView(tableOf: updatedTableOf, questionsLimit: questionsLimit), label: {
                        Text("START")
                            .frame(width: 150, height: 100)
                            .background(.red)
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    })
                }
                .padding()
            }
        }
    }
}

struct EdutainmentLaunchScreen_Previews: PreviewProvider {
    static var previews: some View {
        EdutainmentLaunchScreen()
    }
}
