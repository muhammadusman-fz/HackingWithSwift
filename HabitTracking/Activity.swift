//
//  Activity.swift
//  HackingWithSwift
//
//  Created by Muhammad Usman on 4/8/2022.
//

import Foundation

struct Activity: Codable, Identifiable {
    var id = UUID()
    let title: String
    let description: String
    let completionCount: Int
}
