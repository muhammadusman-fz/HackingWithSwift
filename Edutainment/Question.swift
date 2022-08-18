//
//  Question.swift
//  HackingWithSwift
//
//  Created by Muhammad Usman on 1/8/2022.
//

import Foundation

struct Question: Identifiable {
    var id = UUID()
    var text: String
    var options: [Int]
    
    var answer: Int
    
    static let sampleQuestion = Question(text: "4 X 4 = ?", options: [12, 13, 14, 15] , answer: 12)
}
