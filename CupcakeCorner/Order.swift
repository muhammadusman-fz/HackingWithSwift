//
//  Order.swift
//  HackingWithSwift
//
//  Created by Muhammad Usman on 5/8/2022.
//

import SwiftUI

class Order: ObservableObject {
    @Published var order = Order1()
//    enum Codingkeys: CodingKey {
//        case type, quantity, extraFrosting, addSprinkles, name, address, city, zip
//    }
//
//
//    init() {}
//
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: Codingkeys.self)
//
//        try container.encode(type, forKey: .type)
//        try container.encode(quantity, forKey: .quantity)
//
//        try container.encode(extraFrosting, forKey: .extraFrosting)
//        try container.encode(addSprinkles, forKey: .addSprinkles)
//
//        try container.encode(name, forKey: .name)
//        try container.encode(address, forKey: .address)
//        try container.encode(city, forKey: .city)
//        try container.encode(zip, forKey: .zip)
//    }
//
//    required init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: Codingkeys.self)
//
//        try container.decode(Int.self, forKey: .type)
//        try container.decode(Int.self, forKey: .quantity)
//
//        try container.decode(Bool.self, forKey: .extraFrosting)
//        try container.decode(Bool.self, forKey: .addSprinkles)
//
//        try container.decode(String.self, forKey: .name)
//        try container.decode(String.self, forKey: .address)
//        try container.decode(String.self, forKey: .city)
//        try container.decode(String.self, forKey: .zip)
//    }
}

struct Order1: Codable {
    static let types = ["Vanilla", "Strawberry", "Choclate", "Rainbow"]
    
    var type = 0
    var quantity = 3
    
    var specialRequest = false {
        didSet {
            if specialRequest == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    
    var extraFrosting = false
    var addSprinkles = false
    
    var name = ""
    var address = ""
    var city = ""
    var zip = ""
    
    var hasValidAddress: Bool {
        name.trimmingCharacters(in: .whitespacesAndNewlines).count > 0
        && address.trimmingCharacters(in: .whitespacesAndNewlines).count > 0
        && city.trimmingCharacters(in: .whitespacesAndNewlines).count > 0
        && zip.trimmingCharacters(in: .whitespacesAndNewlines).count > 0
    }
    
    var cost: Double {
        // $2 per cake
        var cost = Double(quantity) * 2
        
        // $1 per cake for extra frosting
        if extraFrosting {
            cost += Double(quantity)
        }
        
        // $0.5 per cake for extra sprinkles
        if addSprinkles {
            cost += Double(quantity) / 2
        }
        
        return cost
    }
    
}
