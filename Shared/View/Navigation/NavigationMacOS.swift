//
//  NavigationMacOS.swift
//  EBookTracking
//
//  Created by Veit Progl on 01.12.20.
//

import SwiftUI

struct NavigationMac: View {
    @State private var showAddView = false
    @EnvironmentObject var sheetData: AddSheetData

    var body: some View {
        VStack() {
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
                    Button(action: {
                        sheetData.selectedSheet = .AddBook
                        sheetData.isOpen.toggle()
                    }) {
                        Label("Add Item", systemImage: "plus")
                    }
                })
            }
            .sheet(isPresented: self.$sheetData.isOpen, content: {
                if sheetData.selectedSheet == .AddBook {
                    AddView(isOpen: self.$showAddView)
                } else if sheetData.selectedSheet == .AddChallenge {
                    AddView(isOpen: self.$showAddView)
                }
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
