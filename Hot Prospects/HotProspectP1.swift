//
//  HotProspectP1.swift
//  SwiftUI 100
//
//  Created by Muhammad Usman on 30/8/2022.
//

import SwiftUI

/// 1. Use of EnvironmentObject
class HotProspect_User: ObservableObject {
    @Published var name = "Muhammad Usman"
}

struct EditView: View {
    @EnvironmentObject var user: HotProspect_User
    
    var body: some View {
        TextField("Name",text: $user.name)
    }
}

struct DisplayView: View {
    @EnvironmentObject var user: HotProspect_User
    
    var body: some View {
        Text(user.name)
    }
}

///3. For objectwillchange

class DelayedUpdater: ObservableObject {
    var value = 0 {
        didSet {
            objectWillChange.send()
        }
    }
    
    init() {
        for i in 1...10 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)) {
                self.value += 1
            }
        }
    }
}

/// Practice
/// 1. Use of property wrapper EnvironmentObject to share the data between different views
/// 2. Use of TabView and switch between different tabs programatically
/// 3. Manually publishing ObservableObject changes with the help of objectwillchange.send()
/// 4. Understanding Result type

struct HotProspectP1: View {
    @StateObject var user = HotProspect_User()
    
    @State private var selectedTab = "One"
    
    @StateObject private var updater = DelayedUpdater()
    
    @State private var output = ""
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            EditView()
            
            DisplayView()
            
            Text("Value is: \(updater.value)")
            
            Text(output)
                .task {
                    await fetchReadings()
                }
            TabView(selection: $selectedTab) {
                ZStack {
                    VStack(spacing: 50) {
                        Image(systemName: "1.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .overlay(Circle().strokeBorder(.blue, lineWidth: 4))
                        
                        Text("Content of tab one")
                        
                        Button("Go to Tab 2") {
                            withAnimation {
                                selectedTab = "Two"
                            }
                        }
                    }
                    
                }
                .tabItem {
                    Label("One", systemImage: "star")
                }
                .tag("One")
                
                ZStack {
                    VStack(spacing: 50) {
                        Image(systemName: "2.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                        
                        Text("Content of tab two")
                        
                        Button("Go to Tab 1") {
                            selectedTab = "One"
                        }
                    }
                    
                }
                .tabItem {
                    Label("Two", systemImage: "circle")
                }
                .tag("Two")
            }
        }
        .padding()
        .environmentObject(user)
    }
    
    /// 4. For Result type
    func fetchReadings() async {
        let fetchTask = Task { () -> String in
            let url = URL(string: "https://hws.dev/readings.json")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let readings = try JSONDecoder().decode([Double].self, from: data)
            return "Found \(readings.count) readings"
        }
        
        let result = await fetchTask.result
        switch result {
        case .success(let str):
            output = str
        case .failure(let error):
            output = "Error: \(error.localizedDescription)"
        }
    }
}

struct HotProspectP_Previews: PreviewProvider {
    static var previews: some View {
        HotProspectP1()
    }
}
