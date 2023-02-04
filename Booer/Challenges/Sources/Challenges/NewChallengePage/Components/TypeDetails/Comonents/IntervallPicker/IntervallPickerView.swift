//
//  IntervallPickerView.swift
//  
//
//  Created Veit Progl on 20.01.23.
//  Copyright © 2023. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

public struct IntervallPickerView: View {
    internal let store: Store<IntervallPickerCore.State, IntervallPickerCore.Action>

    public init(store: Store<IntervallPickerCore.State, IntervallPickerCore.Action>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(store) { viewStore in
            ScrollView(.horizontal) {
                HStack {
                    ForEach(viewStore.state.selectableIntervallTypes) { type in
                        Text(type.rawValue)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 8)
                            .background(Color.systemGray)
                            .cornerRadius(14)
                            .foregroundColor(.white)
                            .overlay(
                                Group{
                                    if viewStore.state.selectedIntervall == type {
                                        RoundedRectangle(cornerRadius: 13)
                                            .stroke(.green, lineWidth: 4)
                                            .padding(2)
                                    } else {
                                        EmptyView()
                                    }
                                }.drawingGroup()
                            )
                            .onTapGesture {
                                viewStore.send(.changeSelection(type))
                            }
                    }
                }
            }
            
        }
    }
}

struct IntervallPickerView_Preview: PreviewProvider {
    static var previews: some View {
        IntervallPickerView(
            store: Store(initialState: IntervallPickerCore.State(value: ""), reducer: IntervallPickerCore())
        )
    }
}
