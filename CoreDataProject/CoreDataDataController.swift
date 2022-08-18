//
//  CoreDataDataController.swift
//  SwiftUI 100
//
//  Created by Muhammad Usman on 15/8/2022.
//

import CoreData
import Foundation

class DataControllerCoreData: ObservableObject {
    let container = NSPersistentContainer(name: "CoreDataProject")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Failed to load core data: \(error.localizedDescription)")
            }
        }
    }
}
