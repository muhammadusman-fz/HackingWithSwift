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
    var connected = false
}

 @MainActor class Prospects: ObservableObject {
    @Published var people: [Prospect]
     
     init() {
         self.people = []
     }
}
