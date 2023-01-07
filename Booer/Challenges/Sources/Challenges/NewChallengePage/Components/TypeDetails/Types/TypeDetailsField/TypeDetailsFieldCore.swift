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
        public init(id: String, field: ChallengeField) {
            self.id = id
            self.field = field
        }
    }

    public enum Action: Equatable {
        case onAppear
        case fieldChanged(String)
    }

    public func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .onAppear:
            return .none
        case let .fieldChanged(newValue):
            state.field.value = newValue
            return .none
        }
    }
}
