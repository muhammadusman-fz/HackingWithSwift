//
//  Data.swift
//  SwiftUI 100
//
//  Created by Muhammad Usman on 25/8/2022.
//

import Foundation

/// Used in Frienfface project
struct User: Codable, Identifiable {
    struct Friend: Codable, Identifiable {
        let id: UUID
        let name: String
    }

    
    let id: UUID
    let isActive: Bool
    let name: String
    let age: Int
    let company: String
    let email: String
    let address: String
    let about: String
    let registered: Date
    let tags: [String]
    let friends: [Friend]
    
    static let example = User(id: UUID(), isActive: true, name: "Paul Hudson", age: 35, company: "Hudson Heavy Industries", email: "paul@hackingwithswift.com", address: "555, Taylor Swift Avenue, Nashville, Tennessee", about: "Paul writes about Swift and iOS development.", registered: Date.now, tags: ["swift", "swiftui", "dogs"], friends: [])
}
