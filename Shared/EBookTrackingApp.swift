//
//  EBookTrackingApp.swift
//  Shared
//
//  Created by Veit Progl on 15.11.20.
//

import SwiftUI

enum addSheets {
    case AddBook
    case AddChallenge
}

class AddSheetData: ObservableObject {
    @Published var selectedSheet = addSheets.AddBook
    @Published var isOpen = false
}

@main
struct EBookTrackingApp: App {
    var sheetData = AddSheetData()
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            VStack() {
                #if os(iOS)
                    TabViewIos()
                #else
                    NavigationMac()
                #endif
            }
            .environmentObject(sheetData)
            .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }

    }
    
    
}

