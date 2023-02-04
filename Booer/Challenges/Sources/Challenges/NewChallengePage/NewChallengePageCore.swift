//
//  NewChallengePageCore.swift
//  
//
//  Created Veit Progl on 03.11.22.
//  Copyright © 2022. All rights reserved.
//

import ComposableArchitecture
import Foundation

public struct NewChallengePageCore: ReducerProtocol {
    public struct State: Equatable {
        var selectedBookId: String?
        var selectedChallengeType: ChallengeType?
        
        public init() {}
        var selectBook: BooksListCore.State {
            get { BooksListCore.State(id: selectedBookId) }
            set { selectedBookId = newValue.selectedBookId }
        }
        var selectType: TypeListCore.State {
            get { TypeListCore.State(selectedType: selectedChallengeType) }
            set { selectedChallengeType = newValue.selectedType }
        }
        
        var typeDetails: TypeDetailsCore.State {
            get { TypeDetailsCore.State(selectedType: selectedChallengeType) }
            set { selectedChallengeType = newValue.selectedType }
        }
    }

    public enum Action: Equatable {
        case onAppear
        case selectBook(BooksListCore.Action)
        case selectType(TypeListCore.Action)
        case selectTypeDetails(TypeDetailsCore.Action)
    }

    struct Environment {
        public init() {}
    }

    public var body: some ReducerProtocol<State, Action> {
        Scope(state: \State.selectBook, action: /Action.selectBook) {
            BooksListCore()
        }
        
        Scope(state: \State.selectType, action: /Action.selectType) {
            TypeListCore()
        }
        
        Scope(state: \State.typeDetails, action: /Action.selectTypeDetails) {
            TypeDetailsCore()
        }
        
        Reduce { state, action in
            return .none
        }
    }
    
}
