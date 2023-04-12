//
//  ChallengeTypesModell.swift
//
//
//  Created by Veit Progl on 28.12.22.
//

import Foundation

public struct ChallengeTypesWrapper: Equatable, Identifiable {
    public var id: String
    
    public static func == (lhs: ChallengeTypesWrapper, rhs: ChallengeTypesWrapper) -> Bool {
        lhs.type.id == rhs.type.id
    }
    
    var type: any ChallengeTypeProtocol
    
    public init(type: any ChallengeTypeProtocol) {
        self.type = type
        self.id = type.id
    }
}

public protocol ChallengeTypeProtocol {
    var id: String { get }
    func getFields() -> [ChallengeField]
    func getType() -> ChallegeTypes
    func getProgress() -> Int
    func getDescription() -> String
    func getTitel() -> String
}

public enum ChallegeTypes: String, Equatable {
    case intervall = "Pages Goal"
    case time = "Time Goal"
    case readingTimeGoal = "Reading Time Goal"
}

struct PagesGoalChallenge: ChallengeTypeProtocol, Equatable, Identifiable {
    var id: String = UUID().uuidString
    
    var type: ChallegeTypes
    var description: String
    var fields: [ChallengeField] = [
                                    ChallengeField(name: "Pages",
                                                   type: .numberField,
                                                   value: ""),
                                    ChallengeField(name: "Intervall",
                                                   type: .intervallPicker,
                                                   value: "")
                                  ]
    var progress: Double
    var titel: String
    
    func getFields() -> [ChallengeField] {
        return fields
    }
    
    func getType()  -> ChallegeTypes {
        return type
    }
    
    func getProgress() -> Int {
        print("getProgress")
        return 0
    }
    
    func getDescription() -> String {
        return description
    }
    
    func getTitel()  -> String{
        return titel
    }
}


struct TimeGoalChallenge: ChallengeTypeProtocol, Equatable, Identifiable {
    var id: String = UUID().uuidString
    
    var type: ChallegeTypes
    var description: String
    var fields: [ChallengeField] = [
                                    ChallengeField(name: "Time",
                                                   type: .numberField,
                                                   value: ""),
                                    ChallengeField(name: "Intervall",
                                                   type: .intervallPicker,
                                                   value: "")
                                  ]
    var progress: Double
    var titel: String
    
    func getFields() -> [ChallengeField] {
        return fields
    }
    
    func getType()  -> ChallegeTypes {
        return type
    }
    
    func getProgress() -> Int {
        print("getProgress")
        return 0
    }
    
    func getDescription() -> String {
        return description
    }
    
    func getTitel()  -> String{
        return titel
    }
}

struct ChallengTypeModell: Equatable {
    
    static let pagesGoal = ChallengeTypesWrapper(type: PagesGoalChallenge(type: ChallegeTypes.intervall,
                                                                        description: "",
                                                                        progress: 0,
                                                                        titel: "Pages Goal"))
    
    static let timeGoal = ChallengeTypesWrapper(type: TimeGoalChallenge(type: .intervall, description: "", progress: 9, titel: "Time Goal"))
    
    static var bookChallengeTypes: [ChallengeTypesWrapper] = [
        pagesGoal, timeGoal
    ]
    
    
}
