//
//  GameScreenView.swift
//  WeSplit-Project-1
//
//  Created by Muhammad Usman on 27/7/22.
//

import SwiftUI

struct GameScreenView: View {
    let moves = ["👊", "✋", "✌️"]
    @State private var computerChoice = Int.random(in: 0...2)
    @State private var shouldWin = Bool.random()
    
    @State private var score = 0
    @State private var questionAsked = 1
    @State private var isShowing = false
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text("Computer has played...")
                    .font(.title)
                
                Text(moves[computerChoice])
                    .font(.system(size: 200))
                
                if shouldWin {
                    Text("Which one wins")
                        .foregroundColor(.green)
                        .font(.headline.bold())
                } else {
                    Text("Which one loose")
                        .foregroundColor(.red)
                        .font(.headline.bold())
                }
                
                HStack {
                    ForEach(0 ..< 3) { number in
                        Button(moves[number]) {
                            play(choice: number)
                        }
                        .font(.system(size: 80))
                        .padding()
                    }
                }
                
                Text("Score: \(score)")
                    .font(.headline.bold())
            }
            .foregroundColor(.white)
            .alert("Game over", isPresented: $isShowing) {
                Button("Play again", action: resetGame)
            } message: {
                Text("Your score was \(score)")
            }
        }
    }
    
    func play(choice: Int) {
        let winningMoves = [1, 2, 0]
        let didWin: Bool
        
        if shouldWin {
            didWin = choice == winningMoves[computerChoice]
        } else {
            didWin = winningMoves[choice] == computerChoice
        }
        
        if didWin {
            score += 1
        }
        
        if questionAsked == 10 {
            isShowing = true
        } else {
            computerChoice = Int.random(in: 0..<3)
            shouldWin = Bool.random()
            questionAsked += 1
        }
    }
    
    func resetGame() {
        questionAsked = 0
        score = 0
        computerChoice = Int.random(in: 0..<3)
        shouldWin = Bool.random()
    }
}

struct GameScreenView_Previews: PreviewProvider {
    static var previews: some View {
        GameScreenView()
    }
}
