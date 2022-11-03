//
//  NewChallengePageView.swift
//  
//
//  Created Veit Progl on 03.11.22.
//  Copyright © 2022. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

public struct NewChallengePageView: View {
    internal let store: Store<NewChallengePageCore.State, NewChallengePageCore.Action>

    public init(store: Store<NewChallengePageCore.State, NewChallengePageCore.Action>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(store) { viewStore in
            Text("Hello world!")
        }
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
