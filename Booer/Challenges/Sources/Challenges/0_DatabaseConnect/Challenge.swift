//
//  File.swift
//  
//
//  Created by Veit Progl on 09.02.23.
//

import Foundation

class BookChallenge: Equatable, Identifiable {
    static func == (lhs: BookChallenge, rhs: BookChallenge) -> Bool {
        lhs.bookId == rhs.bookId
    }
    
    var bookId: String
    var challengeType: ChallengeTypesWrapper
    
    init(bookId: String, challengeType: ChallengeTypesWrapper) {
        self.bookId = bookId
        self.challengeType = challengeType
    }
}
