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
                    ForEach(Array(viewStore.bookChallengeTypes.enumerated()), id: \.element.id) { index, type in
                        HStack() {
                            Image(systemName: "clock.badge.checkmark")
                                .imageScale(.large)
                            Text(type.title)
                                .bold()
                        }
                        .padding(.horizontal, 10)
                        .padding(.vertical, 8)
                        .background(Color.systemGray)
                        .cornerRadius(14)
                        .foregroundColor(.white)
                        .overlay(
                            Group{
                                if viewStore.state.selectedTypeIndex == index {
                                    RoundedRectangle(cornerRadius: 13)
                                        .stroke(.green, lineWidth: 4)
                                        .padding(2)
                                } else {
                                    EmptyView()
                                }
                            }.drawingGroup()
                        )
                        .onTapGesture {
                            viewStore.send(.selectType(index))
                        }
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
