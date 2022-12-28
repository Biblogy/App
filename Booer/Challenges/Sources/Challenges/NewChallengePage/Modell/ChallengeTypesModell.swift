//
//  ChallengeTypesModell.swift
//  
//
//  Created by Veit Progl on 28.12.22.
//

import Foundation

struct ChallengTypeModell {
    private static let pagesGoal = ChallengeType(title: "Pages Goal",
                                          description: "",
                                          fields: [
                                            ChallengeField(name: "Pages",
                                                           type: .numberField,
                                                           value: ""),
                                            ChallengeField(name: "Intervall",
                                                           type: .intervallPicker,
                                                           value: "")
                                          ])
    
    private static let timeGoal = ChallengeType(title: "Time Goal",
                                         description: "",
                                         fields: [])
    
    private static let readingTimeGoal = ChallengeType(title: "Reading Time Goal",
                                                description: "",
                                                fields: [])
    
    static var bookChallengeTypes = [pagesGoal,
                              timeGoal,
                              readingTimeGoal]
    
}
