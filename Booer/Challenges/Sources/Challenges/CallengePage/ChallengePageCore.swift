//
//  ChallengePageCore.swift
//  
//
//  Created Veit Progl on 03.11.22.
//  Copyright © 2022. All rights reserved.
//

import ComposableArchitecture

public enum ChallengePageCore {}

public extension ChallengePageCore {
    struct State: Equatable {
        public init() {}
    }

    enum Action: Equatable {
        case onAppear
    }

    struct Environment {
        public init() {}
    }

    static let reducer = Reducer<State, Action, Environment>.combine(
        .init { state, action, environment in
            return .none
        }
    )
}
