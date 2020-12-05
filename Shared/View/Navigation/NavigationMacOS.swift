//
//  NavigationMacOS.swift
//  EBookTracking
//
//  Created by Veit Progl on 01.12.20.
//

import SwiftUI

struct NavigationMac: View {
    @State private var showAddView = false

    var body: some View {
        NavigationView() {
            Sidebar()
            
            ContentView()
        }
        .toolbar {
            ToolbarItem(placement: ToolbarItemPlacement.navigation, content: {
                Button(action: toggleSidebar, label: {
                    Image(systemName: "sidebar.left")
                })
            })
            ToolbarItem(content: {
                Button(action: {showAddView.toggle()}) {
                    Label("Add Item", systemImage: "plus")
                }
            })
        }
        .sheet(isPresented: self.$showAddView, content: {
            AddView(isOpen: self.$showAddView)
        })
    }
    
    private func toggleSidebar() {
        #if os(iOS)
        #else
        NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
        #endif
    }
}
