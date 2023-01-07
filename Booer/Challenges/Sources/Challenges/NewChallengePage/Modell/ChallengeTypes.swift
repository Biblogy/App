//
//  ChallengeTypes.swift
//  
//
//  Created by Veit Progl on 28.12.22.
//

import Foundation
import SwiftUI
import ComposableArchitecture

public enum ChallengeFieldTypes {
    case textField
    case numberField
    case intervallPicker
}

public class ChallengeField: Identifiable, Equatable, ObservableObject {
    public static func == (lhs: ChallengeField, rhs: ChallengeField) -> Bool {
        return lhs.id == rhs.id
    }
    
    public init(name: String, type: ChallengeFieldTypes, value: String) {
        self.name = name
        self.type = type
        self.value = value
    }
    
    public var id = UUID().uuidString
    public var name: String = ""
    public var type: ChallengeFieldTypes
    public var value: String = ""
}

public struct ChallengeType: Identifiable, Equatable {
    public var id = UUID().uuidString
    var title: String
    var description: String
    
    var fields: [ChallengeField]
}
