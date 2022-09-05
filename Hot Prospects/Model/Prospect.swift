//
//  Prospect.swift
//  SwiftUI 100
//
//  Created by Muhammad Usman on 2/9/2022.
//

import SwiftUI

class Prospect: Identifiable, Codable {
    var id = UUID()
    var name = "Anonymous"
    var email = ""
    fileprivate (set) var connected = false
    
}

 @MainActor class Prospects: ObservableObject {
    @Published private(set) var people: [Prospect]
     
     let key = "HotProspectData"
     init() {
         if let data  = UserDefaults.standard.data(forKey: key) {
             if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
                 people = decoded
                 return
             }
         }
         
         self.people = []
     }
     
     func add(_ prospect: Prospect) {
         people.append(prospect)
         save()
     }
     
     private func save() {
         if let encoded = try? JSONEncoder().encode(people) {
             UserDefaults.standard.set(encoded, forKey: key)
         }
     }
     
     func toggle(_ prospect: Prospect) {
         objectWillChange.send()
         prospect.connected.toggle()
         save()
     }
}
