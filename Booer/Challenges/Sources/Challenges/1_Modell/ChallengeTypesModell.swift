//
//  ChallengeTypesModell.swift
//  
//
//  Created by Veit Progl on 28.12.22.
//

import Foundation

struct ChallengTypeModell {
    static let pagesGoal = ChallengeType(title: "Pages Goal",
                                          description: "",
                                          fields: [
                                            ChallengeField(name: "Pages",
                                                           type: .numberField,
                                                           value: ""),
                                            ChallengeField(name: "Intervall",
                                                           type: .intervallPicker,
                                                           value: "")
                                          ])
    
    static let timeGoal = ChallengeType(title: "Time Goal",
                                         description: "",
                                         fields: [])
    
    static let readingTimeGoal = ChallengeType(title: "Reading Time Goal",
                                                description: "",
                                                fields: [])
    
    static var bookChallengeTypes = [pagesGoal,
                              timeGoal,
                              readingTimeGoal]
    
    
    
}
