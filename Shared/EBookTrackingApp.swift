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
            #if os(iOS)
                TabViewIos()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            #else
                NavigationMac()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            #endif
        }

    }
    
    
}

