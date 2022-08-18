//
//  EdutainmentView.swift
//  HackingWithSwift
//
//  Created by Muhammad Usman on 1/8/2022.
//

import SwiftUI

struct EdutainmentView: View {
    
    var tableOf: Int
    var questionsLimit: Int
    
    @State private var multipleOf = Int.random(in: 2..<11)
    @State private var questionsCount = 1
    @State private var score = 0
    
    @State var question = Question.sampleQuestion
    
    @State private var alertTitle = "Game Over"
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    let columns = [
        GridItem(.fixed(150)),
        GridItem(.fixed(150))
    ]
    
    var questionsData: [Question] {
        var data = [Question]()
        for _ in 0 ..< questionsLimit {
            multipleOf = Int.random(in: 2..<11)
            data.append(Question(
                text: "\(tableOf) X \(multipleOf) = ?",
                options: [
                          (tableOf * multipleOf),
                          (tableOf * multipleOf - 1),
                          (tableOf * multipleOf + 1),
                          (tableOf * multipleOf - 2)
                         ].shuffled(),
                answer: tableOf * multipleOf
                )
            )
        }
        return data
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                VStack {
                    
                    Spacer()
                    
                    Text("\(question.text)")
                        .font(.system(size: 40))
                    
                    LazyVGrid(columns: columns, spacing: 40) {
                        ForEach(question.options, id: \.self) { option in
                            Button("\(option)") {
                                checkResult(option)
                            }
                            .frame(width: 80, height: 80)
                            .background(.cyan)
                            .foregroundColor(.black)
                            .font(.title)
                            .clipShape(Circle())
                        }
                    }
                    
                    Spacer()
                    Spacer()
                    
                    Text("Score: \(score)")
                    Spacer()
                }
                .foregroundColor(.white)
            }
            .alert(alertTitle, isPresented: $showingAlert) {
                    Text("\(score).")
                        .font(.headline)
                
                Button("OK", role: .cancel) {
                    print("\(questionsData)")
                    questionsCount = 0
                    score = 0
                }
            } message: {
                Text("Your score are: \(score)")
            }
            .navigationTitle("Edutainment")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear(perform: askQuestion)
    }
    
    func askQuestion(){
        question = questionsData.randomElement()!
    }
    
    func checkResult(_ value: Int) {
        if value == question.answer {
            score += 1
        }
        
        if questionsCount >= questionsLimit {
            showingAlert = true
        } else {
            questionsCount += 1
            askQuestion()
        }
    }
}

struct EdutainmentView_Previews: PreviewProvider {
    static var previews: some View {
        EdutainmentView(tableOf: 4, questionsLimit: 5)
    }
}
