//
//  TypeDetailsFieldView.swift
//  
//
//  Created Veit Progl on 26.11.22.
//  Copyright © 2022. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

public struct TypeDetailsFieldView: View {
    internal let store: Store<TypeDetailsFieldCore.State, TypeDetailsFieldCore.Action>

    public init(store: Store<TypeDetailsFieldCore.State, TypeDetailsFieldCore.Action>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(store) { viewStore in
            switch viewStore.state.field.type {
            case .textField:
                TextField(viewStore.state.field.name, text: viewStore.binding(get: \.field.value, send: TypeDetailsFieldCore.Action.textFieldChanged))
            case .numberField:
                TextField(viewStore.state.field.name, text: viewStore.binding(get: \.field.value, send: TypeDetailsFieldCore.Action.textFieldChanged))
                    .keyboardType(.numberPad)
            case .intervallPicker:
                TextField(viewStore.state.field.name, text: viewStore.binding(get: \.field.value, send: TypeDetailsFieldCore.Action.textFieldChanged))
            }
        }
    }
}
