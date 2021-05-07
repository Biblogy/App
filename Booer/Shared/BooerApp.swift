//
//  BooerApp.swift
//  Shared
//
//  Created by Veit Progl on 23.04.21.
//

import SwiftUI
import Booer_Shared
import CoreData

#if os(iOS)
import Booer_iOS
#else
import Booer_macOS
#endif

@main
struct BooerApp: App {
    var sheetData = AddSheetData()
    var alertData = DeleteAlert()
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
            .environmentObject(alertData)
            .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
