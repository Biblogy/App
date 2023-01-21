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
        var newChallenge = NewChallengePageCore.State()
    }

    enum Action: Equatable {
        case onAppear
        case newChallenge(NewChallengePageCore.Action)
        case navigateToNewChallenge
        
    }

    struct Environment {
        public init() {}
    }

    static let reducer = Reducer<State, Action, Environment>.combine(
//        NewChallengePageCore.reducer.pullback(state: \.newChallenge, action: /Action.newChallenge, environment: { _ in NewChallengePageCore.Environment() }),
        AnyReducer { environment in
            NewChallengePageCore()
        }.pullback(state: \.newChallenge, action: /Action.newChallenge, environment: { $0 }),
        .init { state, action, environment in
            switch action {
            case .navigateToNewChallenge:
                return .none
            case .newChallenge:
                return .none
            case .onAppear:
                return .none
            }
        }
    )
}
