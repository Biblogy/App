//
//  TypeDetailsFieldCore.swift
//  
//
//  Created Veit Progl on 26.11.22.
//  Copyright © 2022. All rights reserved.
//

import ComposableArchitecture

public struct TypeDetailsFieldCore: ReducerProtocol {
    public struct State: Equatable, Identifiable {
        public var id: String
        var field: ChallengeField
        var intervallPicker: IntervallPickerCore.State {
            get { IntervallPickerCore.State(value: field.value) }
            set { field.value = newValue.selectedIntervall.rawValue }
        }
        
        public init(id: String, field: ChallengeField) {
            self.id = id
            self.field = field
        }
    }

    public enum Action: Equatable {
        case onAppear
        case textFieldChanged(String)
        case numberFieldChanged(String)
        case intervallPicker(IntervallPickerCore.Action)
        
    }

    public var body: some ReducerProtocol<State, Action> {
        Scope(state: \State.intervallPicker, action: /Action.intervallPicker) {
            IntervallPickerCore()
        }
        
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .none
            case let .textFieldChanged(newValue):
                switch state.field.type {
                case .numberField:
                    if newValue == "" {
                        state.field.value = newValue
                        return .none
                    }
                    guard let intValue = Int(newValue) else { return .none }
                    state.field.value = String(intValue)
                case .textField:
                    state.field.value = String(newValue)
                case .intervallPicker:
                    state.field.value = String(newValue)
                }
                return .none
            case .numberFieldChanged(_):
                return .none
            case .intervallPicker:
                return .none
            }
        }
    }
}
