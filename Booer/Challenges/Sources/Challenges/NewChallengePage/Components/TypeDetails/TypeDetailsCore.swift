//
//  TypeDetailsCore.swift
//  
//
//  Created Veit Progl on 26.11.22.
//  Copyright © 2022. All rights reserved.
//

import ComposableArchitecture
import Foundation

/// die Challenge Typem müssen hietr ein Protocoll versteckt werden sodass es hier egal ist welches verwendet wird! Protokolle erlauben das wechseln der Klassen so das es hier flexible bleibt.

public struct TypeDetailsCore: ReducerProtocol {
    public struct State: Equatable {
//        let placeholder = ChallengeType(type: .intervall, description: "", fields: [])
        let placeholder = ChallengeTypesWrapper(type: PagesGoalChallenge(type: .intervall, description: "", progress: 0, titel: ""))
        
        public init(selectedType: ChallengeTypesWrapper?) {
            self.selectedType = selectedType ?? placeholder
            
            self.inputFields = IdentifiedArrayOf(
                uniqueElements: self.selectedType.type.getFields().map { field in
                    TypeDetailsFieldCore.State(id: field.id, field: field)
                })
        }
        
        var selectedType: ChallengeTypesWrapper
        var inputFields: IdentifiedArrayOf<TypeDetailsFieldCore.State>
    }

    public enum Action: Equatable {
        case onAppear
        case typeDetailsField(id: TypeDetailsFieldCore.State.ID,action: TypeDetailsFieldCore.Action)
    }
    
    public var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .none
            case .typeDetailsField(id: _, action: _):
                return .none
            }
        }.forEach(\.inputFields, action: /Action.typeDetailsField) {
            TypeDetailsFieldCore()
        }
    }
}
