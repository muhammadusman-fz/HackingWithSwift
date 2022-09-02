//
//  ProspectView.swift
//  SwiftUI 100
//
//  Created by Muhammad Usman on 2/9/2022.
//

import SwiftUI

struct ProspectView: View {
    enum FilterType {
        case none, contacted, uncontacted
    }
    
    let filter: FilterType
    
    var title: String {
        switch filter {
        case .none:
            return "Everyone"
        case .contacted:
            return "Contacted people"
        case .uncontacted:
            return "Uncontacted people"
        }
    }
    
    @EnvironmentObject var prospects: Prospects
    var filteredProspects: [Prospect] {
        switch filter {
        case .none:
            return prospects.people
        case .contacted:
            return prospects.people.filter { $0.connected }
        case .uncontacted:
            return prospects.people.filter { !$0.connected }
        }
    }
    
    var body: some View {
        VStack {
            List {
                ForEach(filteredProspects) { prospect in
                    VStack(alignment: .leading) {
                        Text(prospect.name)
                            .font(.headline)
                        Text(prospect.email)
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ProspectView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProspectView(filter: .none)
                .environmentObject(Prospects())
        }
    }
}
