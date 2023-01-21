//
//  TypeListCore.swift
//  
//
//  Created Veit Progl on 23.11.22.
//  Copyright © 2022. All rights reserved.
//

import ComposableArchitecture

public struct TypeListCore: ReducerProtocol {
    public struct State: Equatable {
        var selectedType: ChallengeType?
        var bookChallengeTypes: [ChallengeType]
        
        public init(selectedType: ChallengeType?) {
            self.selectedType = selectedType
            self.bookChallengeTypes = ChallengTypeModell.bookChallengeTypes
        }
        
    }

    public enum Action: Equatable {
        case onAppear
        case selectType(ChallengeType)
    }

    public struct Environment {
        public init() {}
    }

    public var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .none
            case .selectType(let type):
                state.selectedType = type
                return .none
            }
        }
    }
}
