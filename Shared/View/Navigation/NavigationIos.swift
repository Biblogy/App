//
//  NavigationIos.swift
//  EBookTracking
//
//  Created by Veit Progl on 01.12.20.
//

import SwiftUI

#if os(iOS)
struct NavigationIos: View {
    @State private var showAddView = false

    var body: some View {
        NavigationView() {
            ContentView()
                .toolbar(content: {
                    ToolbarItem(placement: .navigationBarTrailing, content: {
                        EditButton()
                    })
                    
                    ToolbarItemGroup(placement: .navigationBarTrailing, content: {
                        Button(action: {showAddView.toggle()}) {
                            Label("Add Item", systemImage: "plus")
                        }
                    })
                })
                .navigationBarTitle("Booer")
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .sheet(isPresented: self.$showAddView, content: {
            AddView(isOpen: self.$showAddView)
        })
    }
}
#endif
