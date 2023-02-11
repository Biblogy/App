//
//  File.swift
//  
//
//  Created by Veit Progl on 09.02.23.
//

import Foundation

class BookChallenge {
    var bookId: String
    var challengeType: ChallengeType
    
    init(bookId: String, challengeType: ChallengeType) {
        self.bookId = bookId
        self.challengeType = challengeType
    }
}
