//
//  HotProspectsMainView.swift
//  SwiftUI 100
//
//  Created by Muhammad Usman on 30/8/2022.
//

import CodeScanner
import SwiftUI

struct HotProspectsMainView: View {
    
    @StateObject var prospects = Prospects()
    @State private var isShowingScanner = false
    
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
            .sheet(isPresented: $isShowingScanner) {
                CodeScannerView(codeTypes: [.qr], simulatedData: "Muhammad Usman\nmaaniappdeveloper@gmail.com", completion: { result in
                    isShowingScanner = false
                    switch result {
                    case .success(let result):
                        let details = result.string.components(separatedBy: "\n")
                        guard details.count == 2 else { return }
                        
                        let person = Prospect()
                        person.name = details[0]
                        person.email = details[1]
                        prospects.add(person)
                        
                    case .failure(let error):
                        print("Scanning failed: \(error.localizedDescription)")
                    }
                })
            }
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
                    isShowingScanner = true
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
