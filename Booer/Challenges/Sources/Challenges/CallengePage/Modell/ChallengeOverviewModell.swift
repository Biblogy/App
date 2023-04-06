//
//  File.swift
//  
//
//  Created by Veit Progl on 25.02.23.
//

import Foundation

protocol ChallengeOverviewModellProtocol {
    func getProgress() -> Int
    func getBookTitle() -> String
    func getDescription() -> String
}

class ChallengeOverviewModell: ChallengeOverviewModellProtocol, Equatable, Identifiable {
    static func == (lhs: ChallengeOverviewModell, rhs: ChallengeOverviewModell) -> Bool {
        lhs.challengeId == rhs.challengeId
    }
    
    private let book: Book
    private let description: String
    private let progress: Int
    let challengeId: String
    
    func getProgress() -> Int {
        return progress
    }
    
    func getBookTitle() -> String {
        return book.title
    }
    
    func getDescription() -> String {
        return description
    }
    
    init(book: Book, description: String, progress: Int, challengeId: String) {
        self.book = book
        self.description = description
        self.progress = progress
        self.challengeId = challengeId
    }
}
