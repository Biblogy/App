//
//  ChallengeTypes.swift
//  
//
//  Created by Veit Progl on 28.12.22.
//

import Foundation

enum ChallengeFieldTypes {
    case textField
    case numberField
    case intervallPicker
}

struct ChallengeField: Identifiable, Equatable {
    var id = UUID().uuidString
    var name: String
    var type: ChallengeFieldTypes
    var value: String
}

struct ChallengeType: Identifiable, Equatable {
    var id = UUID().uuidString
    let title: String
    let description: String
    
    let fields: [ChallengeField]
}
