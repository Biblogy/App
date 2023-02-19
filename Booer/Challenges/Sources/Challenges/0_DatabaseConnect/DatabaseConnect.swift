//
//  DatabaseConnect.swift
//  
//
//  Created by Veit Progl on 13.11.22.
//

import Foundation
import DatabaseBooer
import SwiftUI

protocol DatabaseConnectProtocol {
    func getAllBooks() -> [Book]
    func save(bookIntervallPages: BookChallenge)
}


// aktuell braucht das Package neue Logic um mit der Datenbank arbeiten zu können. Schöner wäre wenn das Package unangerührt bleibe und nur ein Protocoll bereit stellt den die Datenbank folge leisten muss.
class DatabaseConnect: DatabaseConnectProtocol {
    func getAllBooks() -> [Book] {
        let allBooks = BiblogyDatabase.shared.books.getAllBooks().map { book -> Book in
            let coverUrl = URL(string: book.cover.thumbnail ?? "") ?? URL(string: "")
            
            return Book(id: book.id,
                        title: book.title,
                        cover: coverUrl!,
                        author: book.author)
        }
        
        return allBooks
    }
    
    func save(bookIntervallPages book: BookChallenge) {
        var databaseIntervall: DatabaseBooer.Intervall?
        var pages: Int?
        
        for field in book.challengeType.fields {
            switch field.type {
            case .intervallPicker:
                if field.value == "month" {
                    databaseIntervall = .month
                } else if field.value == "year" {
                    databaseIntervall = .year
                } else if field.value == "day" {
                    databaseIntervall = .day
                }
            case .numberField:
                pages = Int(field.value) ?? 0
            default:
                print("nope error")
            }
        }
        
        guard let databaseIntervall, let pages else { return }
        
        let bookGoalChallenge = BookIntervallPages(bookID: book.bookId, intervall: databaseIntervall, pages: pages)
        
        BiblogyDatabase().challenge.save_Book_IntervallPagesChallenge(data: bookGoalChallenge)
    }
}
