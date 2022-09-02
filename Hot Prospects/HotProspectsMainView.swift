//
//  HotProspectsMainView.swift
//  SwiftUI 100
//
//  Created by Muhammad Usman on 30/8/2022.
//

import SwiftUI

struct HotProspectsMainView: View {
    @StateObject var prospects = Prospects()
    var body: some View {
        VStack {
            TabView {
                ProspectView(filter: .none)
                    .tabItem {
                        Label("Everyone", systemImage: "person.3")
                    }
                
                ProspectView(filter: .contacted)
                    .tabItem {
                        Label("Contacted", systemImage: "checkmark.circle")
                    }
                
                ProspectView(filter: .uncontacted)
                    .tabItem {
                        Label("Uncontacted", systemImage: "questionmark.diamond")
                    }
                
                MeView()
                    .tabItem {
                        Label("Me", systemImage: "person.crop.square")
                    }
            }
            .environmentObject(prospects)
        }
        .navigationTitle("HotProspect")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem {
                NavigationLink {
                    HotProspectP1()
                } label: {
                    Text("P1")
                }
            }

            ToolbarItem {
                NavigationLink {
                    HotProspectP2()
                } label: {
                    Text("P2")
                }
            }
            
            ToolbarItem {
                Button {
                    let prospect = Prospect()
                    prospect.name = "Muhammad Usman"
                    prospect.email = "maaniappdeveloper@gmail.com"
                    prospects.people.append(prospect)
                } label: {
                    Label("Scan", systemImage: "qrcode.viewfinder")
                }
            }
        }
    }
}

struct HotProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HotProspectsMainView()
        }
    }
}
