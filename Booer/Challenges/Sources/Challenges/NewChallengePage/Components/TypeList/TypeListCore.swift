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
        var bookChallengeTypes = ChallengTypeModell.bookChallengeTypes
        var selectedType: ChallengeType = ChallengeType(title: "", description: "", fields: [])
    }

    enum Action: Equatable {
        case onAppear
        case selectType(ChallengeType)
    }

    struct Environment {
        public init() {}
    }

    static let reducer = Reducer<State, Action, Environment>.combine(
        .init { state, action, environment in
            switch action {
            case .onAppear:
                return .none
            case .selectType(let type):
                state.selectedType = type
                return .none
            }
        }
    )
}
