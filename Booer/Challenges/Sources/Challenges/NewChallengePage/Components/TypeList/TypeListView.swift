//
//  TypeListView.swift
//  
//
//  Created Veit Progl on 23.11.22.
//  Copyright © 2022. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

public struct TypeListView: View {
    internal let store: Store<TypeListCore.State, TypeListCore.Action>

    public init(store: Store<TypeListCore.State, TypeListCore.Action>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(store) { viewStore in
            ScrollView(.horizontal) {
                HStack {
                    ForEach(viewStore.bookChallengeTypes) { type in
                        HStack() {
                            Image(systemName: "clock.badge.checkmark")
                                .imageScale(.large)
                            Text(type.title)
                                .bold()
                        }
                        .padding()
                        .background(Color.systemGray)
                        .cornerRadius(14)
                        .foregroundColor(.white)
                    }
                }
            }
        }
    }
}

struct TypeListView_Preview: PreviewProvider {
    static var previews: some View {
        TypeListView(
            store: Store<TypeListCore.State, TypeListCore.Action>(
                initialState: TypeListCore.State(),
                reducer: TypeListCore.reducer,
                environment: TypeListCore.Environment()
            )
        )
    }
}
