//
//  ChallengePageView.swift
//  
//
//  Created Veit Progl on 03.11.22.
//  Copyright © 2022. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

public struct ChallengePageView: View {
    internal let store: Store<ChallengePageCore.State, ChallengePageCore.Action>

    public init(store: Store<ChallengePageCore.State, ChallengePageCore.Action>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(store) { viewStore in
            NavigationView {
                VStack(){
                    Spacer()
                    Text("Hello world!")
                    Spacer()
                    
                    Button(action: {}) {
                        Text("New Challenge")
                            .frame(minWidth: 0, maxWidth: .infinity)
                    }
                        .buttonStyle(.borderedProminent)
                        .padding([.horizontal], 50)
                }.navigationTitle("Challenges")
            }
        }
    }
}

struct ChallengePageView_Preview: PreviewProvider {
    static var previews: some View {
        ChallengePageView(
            store: Store<ChallengePageCore.State, ChallengePageCore.Action>(
                initialState: ChallengePageCore.State(),
                reducer: ChallengePageCore.reducer,
                environment: ChallengePageCore.Environment()
            )
        )
    }
}
