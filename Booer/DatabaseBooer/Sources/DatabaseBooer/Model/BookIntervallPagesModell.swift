//
//  BookIntervallPagesModell.swift
//  
//
//  Created by Veit Progl on 21.02.23.
//

import Foundation

public struct BookIntervallPagesModell {
    public var bookID: String
    public var intervall: Intervall
    public var pages: Int
    public var challengeID: String
    public var bookTitle: String
    
    public init(bookID:String, intervall: Intervall, pages: Int, challengeID: String = UUID().uuidString, bookTitle: String) {
        self.bookID = bookID
        self.intervall = intervall
        self.pages = pages
        self.challengeID = challengeID
        self.bookTitle = bookTitle
    }
    
    //TODO: better error handling
    public init(from challenge: ChallengeIntervallPages) {
        self.bookID = challenge.book?.id ?? ""
        self.intervall = challenge.intervall
        self.pages = Int(challenge.pages)
        self.challengeID = challenge.id!
        self.bookTitle = challenge.book?.title ?? "error"
    }
}
