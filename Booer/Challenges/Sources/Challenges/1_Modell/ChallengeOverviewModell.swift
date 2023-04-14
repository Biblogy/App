//
//  File.swift
//
//
//  Created by Veit Progl on 25.02.23.
//

import Foundation

protocol ChallengeOverviewModellProtocol {
    func getProgress() -> ProgressState
    func getBookTitle() -> String
    func getDescription() -> String
}

class ChallengeOverviewModell: ChallengeOverviewModellProtocol, Equatable, Identifiable {
    static func == (lhs: ChallengeOverviewModell, rhs: ChallengeOverviewModell) -> Bool {
        lhs.challengeId == rhs.challengeId
    }
    
    private let book: Book
    private let description: String
    private let progress: ProgressState
    private let type: ChallegeTypes
    let challengeId: String
    
    func getProgress() -> ProgressState {
        return progress
    }
    
    func getBookTitle() -> String {
        return book.title
    }
    
    func getDescription() -> String {
        return description
    }
    
    init(book: Book, description: String, progress: ProgressState, challengeId: String, type: ChallegeTypes) {
        self.book = book
        self.description = description
        self.progress = progress
        self.challengeId = challengeId
        self.type = type
    }
    
    init(book: Book, challengeId: String, type: ChallengeType) {
        self.book = book
        self.description = type.description
        self.progress = ProgressState.progress(0)
        self.challengeId = challengeId
        self.type = type.type
    }

}
