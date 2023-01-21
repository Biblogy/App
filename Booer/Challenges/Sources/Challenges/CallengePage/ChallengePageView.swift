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
    
    @State var navigateToNewChallenge = false
    
    public var body: some View {
        WithViewStore(store) { viewStore in
            NavigationView {
                VStack(){
                    Spacer()
                    Text("Hello world!")
                    Spacer()
                    
                    Button(action: {
                        viewStore.send(.navigateToNewChallenge)
                        navigateToNewChallenge.toggle()
                    }) {
                        Text("New Challenge")
                            .frame(minWidth: 0, maxWidth: .infinity)
                    }
                    .ignoresSafeArea(.keyboard, edges: .bottom)
                    .padding([.horizontal], 17)
                    .padding([.vertical], 10)
                    .background(Color.blue)
                    .foregroundColor(Color.white)
                    .cornerRadius(9)
                    .padding()
                }.navigationTitle("Challenges")
                .background(
                    NavigationLink (
                        destination: NewChallengePageView(store: store.scope(state: \.newChallenge, action: ChallengePageCore.Action.newChallenge)),
                        isActive: $navigateToNewChallenge,
                        label: {
                            EmptyView()
                        }
                    )
                )
            }
        }
    }
}

struct ChallengePageView_Preview: PreviewProvider {
    static var previews: some View {
        ChallengePageView(
            store: Store(initialState: ChallengePageCore.State(), reducer: ChallengePageCore())
        )
    }
}
