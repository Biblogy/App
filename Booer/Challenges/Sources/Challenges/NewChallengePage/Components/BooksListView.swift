//
//  BooksListView.swift
//  
//
//  Created Veit Progl on 12.11.22.
//  Copyright © 2022. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

public struct BooksListView: View {
    internal let store: Store<BooksListCore.State, BooksListCore.Action>

    public init(store: Store<BooksListCore.State, BooksListCore.Action>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(store) { viewStore in
            Text("Hello world!")
        }
    }
}

struct BooksListView_Preview: PreviewProvider {
    static var previews: some View {
        BooksListView(
            store: Store<BooksListCore.State, BooksListCore.Action>(
                initialState: BooksListCore.State(),
                reducer: BooksListCore.reducer,
                environment: BooksListCore.Environment()
            )
        )
    }
}
