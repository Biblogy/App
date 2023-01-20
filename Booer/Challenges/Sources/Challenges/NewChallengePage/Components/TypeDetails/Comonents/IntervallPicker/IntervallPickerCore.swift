//
//  IntervallPickerCore.swift
//  
//
//  Created Veit Progl on 20.01.23.
//  Copyright © 2023. All rights reserved.
//

import ComposableArchitecture

public struct IntervallPickerCore: ReducerProtocol {
    public struct State: Equatable {
        public init() {}
    }

    public enum Action: Equatable {
        case onAppear
    }

    public struct Environment {
        public init() {}
    }

    public func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .onAppear:
            return .none
        }
    }
}
