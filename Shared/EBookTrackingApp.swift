//
//  EBookTrackingApp.swift
//  Shared
//
//  Created by Veit Progl on 15.11.20.
//

import SwiftUI

@main
struct EBookTrackingApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
