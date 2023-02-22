//
//  File.swift
//  
//
//  Created by Veit Progl on 16.02.23.
//

import Foundation
import CoreData

public protocol ChallengeDatabaseProtocol {
    func save_Book_IntervallPagesChallenge(data: BookIntervallPagesModell)
}

class ChallengeDatabase: ChallengeDatabaseProtocol {
    var viewContext = PersistenceController.shared.container.viewContext

    func save_Book_IntervallPagesChallenge(data: BookIntervallPagesModell) {
        let newChallenge = ChallengeIntervallPages(context: viewContext)
        newChallenge.id = data.challengeID
        newChallenge.pages = Int16(data.pages)
        newChallenge.intervall = data.intervall
        
        do {
            try viewContext.save()
        } catch {
            print("error")
        }
    }
    
    /*
    func loadAllChallenges() -> [CHallenge] {
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "BooksDB")

        var books: [Book] = []
        do {
            let objects = try viewContext.fetch(fetch)
            for es in objects {
                if let object = es as? BooksDB {
                    books.append(Book(from: object))
                }
            }
        } catch {
            print("error")
        }
        return books
    }
     */
    
    func getAll_BookIntervallPageChallenges() -> [BookIntervallPagesModell] {
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "ChallengeIntervallPages")

        var challenges: [BookIntervallPagesModell] = []
        do {
            let objects = try viewContext.fetch(fetch)
            for es in objects {
                if let object = es as? ChallengeIntervallPages {
//                            books.append(Book(from: object))
                    challenges.append(BookIntervallPagesModell(from: object))
                }
            }
        } catch {
            print("error")
        }
        return challenges
    }
}
