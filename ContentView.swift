//
//  ContentView.swift
//  SwiftUI 100
//
//  Created by Muhammad Usman on 11/8/2022.
//

import SwiftUI

struct Project: Identifiable {
    var id = UUID()
    let title: String
}

struct ContentView: View {
    @State private var projects = ["HotProspects", "Friend Face (Challenge)","Insta Filter","Bookworm", "We Split", "Guess the Flag", "Word Scramble", "Rock Paper Scissor", "Better Rest", "Animations", "Edutainment", "iExpense", "Moonshot", "Habit Tracking", "Cupcake Corner"
    ]
    
    let columns = [
        GridItem(.adaptive(minimum: 160))
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(projects, id: \.self) { project in
                        NavigationLink {
                            switch(project) {
                            case "HotProspects":
                                HotProspectsMainView()
                            case "Friend Face (Challenge)":
                                FriendFaceView()
                            case "Insta Filter":
                                InstaFilterMainView()
                            case "We Split":
                                WeSplitView()
                            case "Guess the Flag":
                                GuessTheFlagScreenView()
                            case "Word Scramble":
                                WordScrambleView()
                            case "Rock Paper Scissor":
                                GameScreenView()
                            case "Better Rest":
                                BetterRestMainView()
                            case "Animations":
                                AnimationViewP()
                            case "Edutainment":
                                EdutainmentLaunchScreen()
                            case "iExpense":
                                iExpenseMainView()
                            case "Habit Tracking":
                                HabitTrackingMainView()
                            case "Cupcake Corner":
                                CupcakeCornerMainView()
                            case "Bookworm":
                                BookwormView()
                            default:
                                MoonshotMainView()
                            }
                        } label: {
                            Text(project)
                                .frame(width: 140, height: 140)
                                .padding(.horizontal)
                                .foregroundColor(.black)
                                .background(.white.opacity(0.5))
                                .font(.title2)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color(red: 0.1, green: 0.1, blue: 0.2))
                                )
                        }
                    }
                }
                .padding(.horizontal)
            }
            .padding(.bottom)
            .background(.white.opacity(0.75))
            .navigationBarTitle("SwiftUI 100")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
