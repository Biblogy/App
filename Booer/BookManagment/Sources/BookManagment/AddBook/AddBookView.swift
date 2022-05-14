//
//  AddBookView.swift
//  
//
//  Created Veit Progl on 13.05.22.
//  Copyright © 2022. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

public struct AddBookView: View {
    internal let store: Store<AddBookCore.State, AddBookCore.Action>

    fileprivate struct ViewState: Equatable {
        init(state: AddBookCore.State) {}
    }

    fileprivate enum ViewAction: Equatable {
        case onAppear
    }

    public init(store: Store<AddBookCore.State, AddBookCore.Action>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(
            store.scope(
                state: ViewState.init,
                action: AddBookCore.Action.init
            )
        ) { viewStore in
            Text("Hello world!")
        }
    }
}

extension AddBookCore.Action {
    fileprivate init(action: AddBookView.ViewAction) {
        switch action {
        case .onAppear:
            self = .onAppear
        }
    }
}

struct AddBookView_Preview: PreviewProvider {
    static var previews: some View {
        AddBookView(
            store: Store<AddBookCore.State, AddBookCore.Action>(
                initialState: AddBookCore.State(),
                reducer: AddBookCore.reducer,
                environment: AddBookCore.Environment()
            )
        )
    }
}
