//
//  TimeGoalDetailsView.swift
//  
//
//  Created Veit Progl on 26.11.22.
//  Copyright © 2022. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

public struct TimeGoalDetailsView: View {
    internal let store: Store<TimeGoalDetailsCore.State, TimeGoalDetailsCore.Action>

    public init(store: Store<TimeGoalDetailsCore.State, TimeGoalDetailsCore.Action>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(store) { viewStore in
            Text("Hello world!")
        }
    }
}

struct TimeGoalDetailsView_Preview: PreviewProvider {
    static var previews: some View {
        TimeGoalDetailsView(
            store: Store<TimeGoalDetailsCore.State, TimeGoalDetailsCore.Action>(
                initialState: TimeGoalDetailsCore.State(),
                reducer: TimeGoalDetailsCore.reducer,
                environment: TimeGoalDetailsCore.Environment()
            )
        )
    }
}
