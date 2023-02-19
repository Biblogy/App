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

public struct NewChallengePageView: View {
    internal let store: Store<NewChallengePageCore.State, NewChallengePageCore.Action>

    public init(store: Store<NewChallengePageCore.State, NewChallengePageCore.Action>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(store) { viewStore in
            ZStack {
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
                    
                    Section("challenge type") {
                        TypeDetailsView(store: store.scope(state: \.typeDetails, action: NewChallengePageCore.Action.selectTypeDetails))
                    }
                    .listRowBackground(Color.clear)
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                }
                
                VStack() {
                    Spacer()
                    
                    Button(action: {
                        viewStore.send(.saveChallenge)
                    }) {
                        Text("Save")
                            .frame(minWidth: 0, maxWidth: .infinity)
                    }
                    .ignoresSafeArea(.keyboard, edges: .bottom)
                    .padding([.horizontal], 17)
                    .padding([.vertical], 10)
                    .background(Color.blue)
                    .foregroundColor(Color.white)
                    .cornerRadius(9)
                    .padding()
                }
            }
            .navigationTitle("Create a challenge")
            .onAppear(perform: {
                viewStore.send(.onAppear)
            })
        }
    }
}

struct NewChallengePageView_Preview: PreviewProvider {
    static var previews: some View {
        NewChallengePageView(
            store: Store(initialState: NewChallengePageCore.State(), reducer: NewChallengePageCore())
        )
    }
}
