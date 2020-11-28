//
//  Sidebar.swift
//  EBookTracking
//
//  Created by Veit Progl on 17.11.20.
//

import SwiftUI
import Combine

enum NavigationViews {
    case BookToReadView
    case BookDoneReadView
}

class NavigationItem: ObservableObject {
    init() {
    }
}

struct Sidebar: View {
    var body: some View {
        VStack(alignment: HorizontalAlignment.leading) {
            Text("Hello, World!")
            Spacer()
        }.frame(minWidth: 0, maxWidth: .infinity)
    }
}

struct Sidebar_Previews: PreviewProvider {
    static var previews: some View {
        Sidebar()
    }
}
