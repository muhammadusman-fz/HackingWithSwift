//
//  MoonshotMainView.swift
//  HackingWithSwift
//
//  Created by Muhammad Usman on 3/8/2022.
//

import SwiftUI

struct MoonshotMainView: View {
    private let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    private let missions: [Mission] = Bundle.main.decode("missions.json")
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(missions) { mission in
                    NavigationLink {
                        MissionDetailView(mission: mission, astronauts: astronauts)
                    } label: {
                        MissionCardView(mission: mission)
                    }
                }
            }
            .padding([.horizontal, .bottom])
            
        }
        .navigationTitle("Moonshot")
        .background(.darkBackground)
        .preferredColorScheme(.dark)
    }
}

struct MoonshotMainView_Previews: PreviewProvider {
    static var previews: some View {
        MoonshotMainView()
    }
}
