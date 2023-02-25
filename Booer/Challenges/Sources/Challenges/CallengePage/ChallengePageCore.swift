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
        var intervallPage = IntervallPageOverviewCore.State()
    }

    public enum Action: Equatable {
        case onAppear
        case newChallenge(NewChallengePageCore.Action)
        case navigateToNewChallenge
        
        case intervallPageOverview(IntervallPageOverviewCore.Action)
    }

    public var body: some ReducerProtocol<State, Action> {
        Scope(state: \State.newChallenge, action: /Action.newChallenge) {
            NewChallengePageCore()
        }
        
        Scope(state: \State.intervallPage, action: /Action.intervallPageOverview) {
            IntervallPageOverviewCore()
        }
        
        Reduce { state, action in
            switch action {
            case .navigateToNewChallenge:
                return .none
            case .newChallenge:
                return .none
            case .onAppear:
                return .none
            case .intervallPageOverview:
                return .none
            }
        }
    }
}
