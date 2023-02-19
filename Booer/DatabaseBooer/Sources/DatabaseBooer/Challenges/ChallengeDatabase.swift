//
//  File.swift
//  
//
//  Created by Veit Progl on 16.02.23.
//

import Foundation
import CoreData

public struct BookIntervallPages {
    var bookID: String
    var intervall: Intervall
    var pages: Int
    
    public init(bookID:String, intervall: Intervall, pages: Int ) {
        self.bookID = bookID
        self.intervall = intervall
        self.pages = pages
    }
}

public protocol ChallengeDatabaseProtocol {
    func save_Book_IntervallPagesChallenge(data: BookIntervallPages)
}

class ChallengeDatabase: ChallengeDatabaseProtocol {
    private var viewContext = PersistenceController.shared.container.viewContext

    func save_Book_IntervallPagesChallenge(data: BookIntervallPages) {
        let newChallenge = ChallengeIntervallPages(context: viewContext)
        newChallenge.id = UUID().uuidString
        newChallenge.pages = Int16(data.pages)
        newChallenge.intervall = data.intervall
        
        do {
            try viewContext.save()
        } catch {
            print("error")
        }
    }
}
