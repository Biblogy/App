//
//  EBookTrackingApp.swift
//  Shared
//
//  Created by Veit Progl on 15.11.20.
//

//import SwiftUI
//import CoreData
//
//@main
//struct EBookTrackingApp: App {
//    var sheetData = AddSheetData()
//    var alertData = DeleteAlert()
//    let persistenceController = PersistenceController.shared
//
//    var body: some Scene {
//        WindowGroup {
//            VStack() {
//                #if os(iOS)
//                    TabViewIos()
//                #else
//                    NavigationMac()
//                #endif
//            }
//            .environmentObject(sheetData)
//            .environmentObject(alertData)
//            .environment(\.managedObjectContext, persistenceController.container.viewContext)
//            .onAppear(perform: {
//                getCoreDataDBPath()
//            })
//        }
//
//    }
//    
//    func getCoreDataDBPath() {
//        let path = FileManager
//            .default
//            .urls(for: .applicationSupportDirectory, in: .userDomainMask)
//            .last?
//            .absoluteString
//            .removingPercentEncoding
//
//        print("Core Data DB Path :: \(path ?? "Not found")")
//    }
//    
//    
//}

