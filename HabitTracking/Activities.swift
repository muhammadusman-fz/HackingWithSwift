//
//  Activities.swift
//  HackingWithSwift
//
//  Created by Muhammad Usman on 4/8/2022.
//

import SwiftUI

class Activities: ObservableObject {
    
    @Published var activities = [Activity]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(activities) {
                UserDefaults.standard.set(encoded, forKey: "activities")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "activities") {
            if let value = try? JSONDecoder().decode([Activity].self, from: savedItems) {
                activities = value
                return
            }
        }
        
        activities = []
    }
}
