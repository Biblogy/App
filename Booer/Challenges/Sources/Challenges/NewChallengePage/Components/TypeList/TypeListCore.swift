//
//  TypeListCore.swift
//  
//
//  Created Veit Progl on 23.11.22.
//  Copyright © 2022. All rights reserved.
//

import ComposableArchitecture

public enum TypeListCore {}

public extension TypeListCore {
    struct State: Equatable {
        public init() {}
        var bookChallengeTypes = [ChallengeType(title: "Pages Goal", description: ""),
                                  ChallengeType(title: "Time Goal", description: ""),
                                  ChallengeType(title: "Reading Time Goal", description: "")]
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
