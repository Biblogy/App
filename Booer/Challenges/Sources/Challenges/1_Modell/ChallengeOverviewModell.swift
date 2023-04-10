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
    private let type: ChallengeTypes
    let challengeId: String
    
    func getProgress() -> Int {
//        if type == .intervall {
//            return CalcIntervallPage().isFailed(pages: <#T##Int#>, intervall: <#T##IntervallTypes#>, progressData: <#T##[ProgressData]#>, start: <#T##Date#>, end: <#T##Date#>, book: <#T##Book#>)
//        }
        return progress
    }
    
    func getBookTitle() -> String {
        return book.title
    }
    
    func getDescription() -> String {
        return description
    }
    
    init(book: Book, description: String, progress: Int, challengeId: String, type: ChallengeTypes) {
        self.book = book
        self.description = description
        self.progress = progress
        self.challengeId = challengeId
        self.type = type
    }
}
