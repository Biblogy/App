//
//  NavigationIos.swift
//  EBookTracking
//
//  Created by Veit Progl on 01.12.20.
//

import SwiftUI

#if os(iOS)

struct TabViewIos: View {
    var body: some View {
        TabView {
            NavigationIos()
                .tabItem { Label("Books to read", systemImage: "books.vertical")}
            BooksDoneRead()
                .tabItem { Label("Books Done", systemImage: "books.vertical.fill")}
            ChallengeView()
                .tabItem { Label("Challenges", systemImage: "checkmark.seal") }
        }
    }
}

struct NavigationIos: View {
    @State private var showAddView = false
    @EnvironmentObject var sheetData: AddSheetData

    var body: some View {
        NavigationView() {
            ContentView()
                .toolbar(content: {
                    ToolbarItem(placement: .navigationBarTrailing, content: {
                        EditButton()
                    })
                    
                    ToolbarItemGroup(placement: .navigationBarTrailing, content: {
                        Button(action: {self.sheetData.isOpen.toggle()}) {
                            Label("Add Item", systemImage: "plus")
                        }
                    })
                })
                .navigationBarTitle("Booer")
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .sheet(isPresented: self.$sheetData.isOpen, content: {
            if sheetData.selectedSheet == .AddBook {
                AddView(isOpen: self.$showAddView)
            } else if sheetData.selectedSheet == .AddChallenge {
                AddView(isOpen: self.$showAddView)
            }
        })
    }
}
#endif
