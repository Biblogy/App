//
//  Sidebar.swift
//  EBookTracking
//
//  Created by Veit Progl on 17.11.20.
//

import SwiftUI
import Combine
import Booer_Shared

enum NavigationActive: String {
    case Book
    case BookDone
    case Challenge
}

class navigationData: ObservableObject {
    var selected = NavigationActive.Book
    
    func checkActive(book: NavigationActive) -> Binding<Bool> {
        return Binding<Bool> (get: {
            if book == self.selected {
               return true
           }
           return true
        }, set: {
            _ = $0
        })
    }
}

struct Sidebar: View {
    @State private var navigation = navigationData()
    
    var body: some View {
        List() {
            Group() {
                Text(navigation.selected.rawValue)
            }
            Group() {
                NavigationLink(destination: BookOverview(), label: {
                    Label("Books to read", systemImage: "book")
                })
                NavigationLink(destination: BooksDoneRead(), label: {
                    Label("Books Done", systemImage: "book.closed")
                })
                NavigationLink(destination: ChallengeView(), label: {
                    Label("Challenges", systemImage: "book.closed")
                })
            }
            
            Spacer()
        }.frame(minWidth: 0, maxWidth: .infinity)
        .toolbar {
            ToolbarItem(content: {
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

struct Sidebar_Previews: PreviewProvider {
    static var previews: some View {
        Sidebar()
    }
}
