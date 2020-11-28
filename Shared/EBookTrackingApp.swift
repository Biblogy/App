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
                NavigationIos()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            #else
                NavigationMac()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            #endif
        }

    }
    
    
}

#if os(iOS)
struct NavigationIos: View {
    var body: some View {
        NavigationView() {
            ContentView()
        }
        .navigationViewStyle(StackNavigationViewStyle())
//        .toolbar {
//            ToolbarItem(placement: .navigation) {
//                Button(action: toggleSidebar, label: {
//                    Image(systemName: "sidebar.left")
//                })
//            }
//        }
    }
}
#endif

struct NavigationMac: View {
    @ObservedObject var items = NavigationItemData(view: .BookToReadView)
    var body: some View {
        NavigationView() {
            Sidebar(items: items)
            
            VStack() {
                switch items.view {
                case .BookToReadView:
                    ContentView()
                case .BookDoneReadView:
                    BooksDoneRead()
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: ToolbarItemPlacement.navigation, content: {
                Button(action: toggleSidebar, label: {
                    Image(systemName: "sidebar.left")
                })
            })
        }
    }
    
    private func toggleSidebar() {
        #if os(iOS)
        #else
        NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
        #endif
    }

}

