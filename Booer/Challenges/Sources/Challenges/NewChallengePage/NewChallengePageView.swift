//
//  NewChallengePageView.swift
//  
//
//  Created Veit Progl on 03.11.22.
//  Copyright © 2022. All rights reserved.
//

import SwiftUI
import ComposableArchitecture
import BooerKit
@_exported import HotSwiftUI

public struct NewChallengePageView: View {
    #if DEBUG
   @ObservedObject var iO = injectionObserver
   #endif
    
    internal let store: Store<NewChallengePageCore.State, NewChallengePageCore.Action>

    public init(store: Store<NewChallengePageCore.State, NewChallengePageCore.Action>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(store) { viewStore in
                List() {
                    Section("select a book") {
                        BooksListView(store: store.scope(state: \.selectBook, action: NewChallengePageCore.Action.selectBook))
                            .listRowBackground(Color.clear)
                            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    }
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    
                    Section("challenge type") {
                        TypeListView(store: store.scope(state: \.selectType, action: NewChallengePageCore.Action.selectType))
                    }
                    .listRowBackground(Color.clear)
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                }
            .navigationTitle("Create a challenge")
            .onAppear(perform: {
                viewStore.send(.onAppear)
            })
        }.eraseToAnyView()
    }
}

struct NewChallengePageView_Preview: PreviewProvider {
    static var previews: some View {
        NewChallengePageView(
            store: Store<NewChallengePageCore.State, NewChallengePageCore.Action>(
                initialState: NewChallengePageCore.State(),
                reducer: NewChallengePageCore.reducer,
                environment: NewChallengePageCore.Environment()
            )
        )
    }
}
