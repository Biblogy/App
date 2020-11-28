//
//  Sidebar.swift
//  EBookTracking
//
//  Created by Veit Progl on 17.11.20.
//

import SwiftUI
import Combine

class NavigationViewsItem: Identifiable {
    var id: String
    var view: NavigationViews
    
    init(view: NavigationViews) {
        self.id = UUID().uuidString
        self.view = view
    }
    
}

enum NavigationViews: String {
    case BookToReadView = "Books to Read"
    case BookDoneReadView = "Books Done"
    
    static let allValues = [NavigationViewsItem(view: BookToReadView), NavigationViewsItem(view: BookDoneReadView)]
}

class NavigationItemData: ObservableObject {
    
    @Published var view: NavigationViews
    
    init(view: NavigationViews) {
        self.view = view
    }
}

struct Sidebar: View {
    @ObservedObject var items: NavigationItemData
    
    var body: some View {
        VStack(alignment: HorizontalAlignment.leading) {
            ForEach(NavigationViews.allValues) { item in
                Button(action: {
                    items.view = item.view
                }, label: {
                    Text(item.view.rawValue)
                })
            }
            Spacer()
        }.frame(minWidth: 0, maxWidth: .infinity)
    }
}

struct Sidebar_Previews: PreviewProvider {
    static var previews: some View {
        Sidebar(items: NavigationItemData(view: .BookToReadView))
    }
}
