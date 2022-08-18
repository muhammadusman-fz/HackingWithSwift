//
//  MissionDescriptionView.swift
//  HackingWithSwift
//
//  Created by Muhammad Usman on 3/8/2022.
//

import SwiftUI

struct MissionDescriptionView: View {
    let mission: Mission
    var body: some View {
        VStack(alignment: .leading) {
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.secondary)
                .padding(.vertical)
            
            Text("Mission Highlights")
                .font(.title.bold())
                .padding(.bottom, 5)
            
            Text(mission.description)
            
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.secondary)
                .padding(.vertical)
            
            Text("Crew")
                .font(.title.bold())
                .padding(.bottom, 5)
        }
        .padding(.horizontal)
    }
}

