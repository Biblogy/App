//
//  BooerApp.swift
//  Shared
//
//  Created by Veit Progl on 23.04.21.
//

import SwiftUI
import Booer_Shared
import CoreData
import Booer_iOS

#if os(iOS)
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
                    TestIos()
                #else
                    NavigationMac()
                #endif
            }
            .environmentObject(sheetData)
            .environmentObject(alertData)
            .environment(\.managedObjectContext, persistenceController.container.viewContext)
            .onAppear(perform: {
                self.alertData.context = persistenceController.container.viewContext
                let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
                print(urls[urls.count-1] as URL)
            })
        }
    }
}
