//
//  GuessTheFlagScreenView.swift
//  WeSplit-Project-1
//
//  Created by Muhammad Usman on 26/7/22.
//

import SwiftUI

struct GuessTheFlagScreenView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var score = 0
    @State private var questionAsked = 1
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .red]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .foregroundColor(.white)
                    .font(.largeTitle.bold())
                VStack(spacing: 10) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagClicked(number)
                        } label: {
                            FlagImage(image: countries[number])
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Restart", action: restart)
        } message: {
            Text("Your score is \(score)")
        }
        
    }
    
    func askQuestion() {
        if questionAsked >= 10 {
            scoreTitle = score >= 5 ? "Congratulations" : "Good luck for next time"
            showingScore = true
        } else {
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
            questionAsked += 1
        }
    }
    
    func flagClicked(_ number: Int) {
        if number == correctAnswer {
            score += 1
        }
        askQuestion()
    }
    
    func restart() {
        score = 0
        questionAsked = 0
        askQuestion()
    }
}

struct GuessTheFlagScreenView_Previews: PreviewProvider {
    static var previews: some View {
        GuessTheFlagScreenView()
    }
}

struct FlagImage: View {
    let image: String
    var body: some View {
        Image(image)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}
