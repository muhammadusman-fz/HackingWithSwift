//
//  HackingWithSwiftApp.swift
//  HackingWithSwift
//
//  Created by Muhammad Usman on 31/7/2022.
//

import SwiftUI

@main
struct HackingWithSwiftApp: App {
    @StateObject private var dataController = DataController()
    @StateObject private var coreDataController = DataControllerCoreData()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environment(\.managedObjectContext, coreDataController.container.viewContext)
        }
    }
}
