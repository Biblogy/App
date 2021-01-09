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
            .sheet(isPresented: self.$sheetData.isOpen, content: {
                if sheetData.selectedSheet == .AddBook {
                    AddView(isOpen: self.$sheetData.isOpen)
                } else if sheetData.selectedSheet == .AddChallenge {
                    AddChallenge(isOpen: self.$sheetData.isOpen)
                }
            })
        }
    }
}
