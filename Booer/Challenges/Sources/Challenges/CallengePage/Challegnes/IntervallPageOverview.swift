//
//  IntervallPageOvewviewView.swift
//  
//
//  Created Veit Progl on 23.02.23.
//  Copyright © 2023. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

public struct IntervallPageOverview: View {
    internal let store: Store<IntervallPageOverviewCore.State, IntervallPageOverviewCore.Action>

    public init(store: Store<IntervallPageOverviewCore.State, IntervallPageOverviewCore.Action>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(store) { viewStore in
            VStack(alignment: .leading){
                ForEach(viewStore.state.challenges) {challenge in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(challenge.getBookTitle())
                            Text(challenge.getDescription())
                        }
                        Spacer()
                        VStack(alignment: .trailing) {
                            Text(String(challenge.getProgress()) + "%").bold()
                        }
                    }
                    ProgressView("", value: 20, total: 100)

                    Divider()
                }
            }.onAppear {
                viewStore.send(.onAppear)
            }
        }
    }
}

struct IntervallPageOvewviewView_Preview: PreviewProvider {
    static var previews: some View {
        IntervallPageOverview(
            store: Store(initialState: IntervallPageOverviewCore.State(), reducer: IntervallPageOverviewCore())
        )
    }
}
