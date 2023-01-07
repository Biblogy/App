//
//  NewChallengePageCore.swift
//  
//
//  Created Veit Progl on 03.11.22.
//  Copyright © 2022. All rights reserved.
//

import ComposableArchitecture
import Foundation

public enum NewChallengePageCore {}

public extension NewChallengePageCore {
    struct State: Equatable {
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

    enum Action: Equatable {
        case onAppear
        case selectBook(BooksListCore.Action)
        case selectType(TypeListCore.Action)
        case selectTypeDetails(TypeDetailsCore.Action)
    }

    struct Environment {
        public init() {}
    }

    static let reducer = Reducer<State, Action, Environment>.combine(
        BooksListCore.reducer.pullback(state: \State.selectBook, action: /Action.selectBook, environment: { _ in BooksListCore.Environment() }),
        TypeListCore.reducer.pullback(state: \State.selectType, action: /Action.selectType, environment: { _ in TypeListCore.Environment() }),
        TypeDetailsCore.reducer.pullback(state: \State.typeDetails, action: /Action.selectTypeDetails, environment: { _ in TypeDetailsCore.Environment() }),
        .init { state, action, environment in
            return .none
        }
    )
}
