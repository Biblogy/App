//
//  Sidebar.swift
//  EBookTracking
//
//  Created by Veit Progl on 17.11.20.
//

import SwiftUI
import Combine

struct Sidebar: View {    
    var body: some View {
        List() {
            Group() {
                NavigationLink(destination: ContentView(), label: {
                    Label("Books to read", systemImage: "book")
                })
                NavigationLink(destination: BooksDoneRead(), label: {
                    Label("Books Done", systemImage: "book.closed")
                })
            }
            Spacer()
        }.frame(minWidth: 0, maxWidth: .infinity)
    }
}

struct Sidebar_Previews: PreviewProvider {
    static var previews: some View {
        Sidebar()
    }
}
