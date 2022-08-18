//
//  MissionView.swift
//  HackingWithSwift
//
//  Created by Muhammad Usman on 3/8/2022.
//

import SwiftUI

struct CrewMemeber {
    let role: String
    let astronaut: Astronaut
}

struct MissionDetailView: View {
    let mission: Mission
    let crew: [CrewMemeber]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.6)
                        .padding(.top)
                    
                    MissionDescriptionView(mission: mission)
                    
                    CrewMembersView(crew: crew)
                }
                .padding(.bottom)
            }
            .frame(maxWidth: .infinity)
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .preferredColorScheme(.dark)
    }
    
    init(mission: Mission, astronauts: [String : Astronaut]) {
        self.mission = mission
        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMemeber(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Could not find \(member.name)")
            }
        }
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    static var previews: some View {
        MissionDetailView(mission: missions[2], astronauts: astronauts)
            .preferredColorScheme(.dark)
    }
}
