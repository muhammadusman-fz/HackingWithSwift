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
    fileprivate (set) var isConnected = false
}

 @MainActor class Prospects: ObservableObject {
    @Published private(set) var people: [Prospect]
     
     let key = "HotProspectData"
     
     let savePath = FileManager.documentDirectory.appendingPathComponent("HotProspectData")
     
//     init() {
//         if let data  = UserDefaults.standard.data(forKey: key) {
//             if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
//                 people = decoded
//                 return
//             }
//         }
//
//         self.people = []
//     }
     
     init() {
         if let data  = try? Data(contentsOf: savePath) {
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
       //      UserDefaults.standard.set(encoded, forKey: key)
             try? encoded.write(to: savePath, options: [.atomic, .completeFileProtection])
         }
     }
     
     func toggle(_ prospect: Prospect) {
         objectWillChange.send()
         prospect.isConnected.toggle()
         save()
     }
}

/// Challenge
extension FileManager {
    static var documentDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
