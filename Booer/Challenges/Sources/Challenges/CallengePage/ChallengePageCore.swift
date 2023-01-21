//
//  ChallengePageCore.swift
//  
//
//  Created Veit Progl on 03.11.22.
//  Copyright © 2022. All rights reserved.
//

import ComposableArchitecture

public struct ChallengePageCore: ReducerProtocol {
    public init() {}
    
    public struct State: Equatable {
        public init() {}
        var newChallenge = NewChallengePageCore.State()
    }

    public enum Action: Equatable {
        case onAppear
        case newChallenge(NewChallengePageCore.Action)
        case navigateToNewChallenge
        
    }

    public var body: some ReducerProtocol<State, Action> {
        //        NewChallengePageCore.reducer.pullback(state: \.newChallenge, action: /Action.newChallenge, environment: { _ in NewChallengePageCore.Environment() }),
        Scope(state: \State.newChallenge, action: /Action.newChallenge) {
            NewChallengePageCore()
        }
        
        Reduce { state, action in
            switch action {
            case .navigateToNewChallenge:
                return .none
            case .newChallenge:
                return .none
            case .onAppear:
                return .none
            }
        }
    }
}
