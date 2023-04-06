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
    func loadAllIntervallPage() -> [ChallengeOverviewModell]
}


// aktuell braucht das Package neue Logic um mit der Datenbank arbeiten zu können. Schöner wäre wenn das Package unangerührt bleibe und nur ein Protocoll bereit stellt den die Datenbank folge leisten muss.
class DatabaseConnect: DatabaseConnectProtocol {
    func getAllBooks() -> [Book] {
        let allBooks = BiblogyDatabase.shared.books.getAllBooks().map { book -> Book in
            let coverUrl = URL(string: book.cover.thumbnail ?? "") ?? URL(string: "")
            
            return Book(id: book.id,
                        title: book.title,
                        cover: coverUrl!,
                        author: book.author,
                        pages: Int(book.pageCount))
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
        
        let bookTitleResult = BiblogyDatabase().books.getBook(id: book.bookId)
        var bookTitle = ""
        switch bookTitleResult {
        case .success(let book):
            guard let title = book.title else { return }
            bookTitle = title
        case .failure(_):
            print("error")
            return
        }
        
        let bookGoalChallenge = BookIntervallPagesModell(bookID: book.bookId, intervall: databaseIntervall, pages: pages, bookTitle: bookTitle)
        
        BiblogyDatabase().challenge.save_Book_IntervallPagesChallenge(data: bookGoalChallenge)
    }
    
    
    //TODO: create a factory to produce Generell Modell from Spezific Data
    func loadAllIntervallPage() -> [ChallengeOverviewModell] {
        let intervallChallenges = BiblogyDatabase().challenge.getAll_BookIntervallPageChallenges()
        var challenges: [ChallengeOverviewModell] = []
        
        for intervallChallenge in intervallChallenges {
            let page = ChallengeField(name: "Page", type: .numberField, value: String(intervallChallenge.pages))
            let intervall = ChallengeField(name: "Intervall", type: .intervallPicker, value: "month")
            
            switch intervallChallenge.intervall {
            case .month:
                intervall.value = "month"
            case .day:
                intervall.value = "day"
            case .week:
                intervall.value = "week"
            case .year:
                intervall.value = "year"
            }
                        
            let challengeDescription = "Read \(page.value) Pages every \(intervall.value)"
            
            let bookResult = BiblogyDatabase().books.getBook(id: intervallChallenge.bookID)
            
//            let progress = CalcIntervallPage()
            
            switch bookResult {
            case .success(let bookdb):
                guard let bookID = bookdb.id,
                        let bookTitle = bookdb.title,
                        let bookCover = bookdb.coverThumbnail,
                        let bookAuthor = bookdb.bookAuthos else { return [] }
                
                let bookPages = Int(bookdb.pages)
                
                guard let bookCoverUrl = URL(string: bookCover) else { return [] }
//                let bookAuthors  = bookAuthor.map( $0.name )
                
                let book = Book(id: bookID,
                                title: bookTitle,
                                cover: bookCoverUrl,
                                author: [],
                                pages: bookPages)
                
                let overview = ChallengeOverviewModell(book: book, description: challengeDescription, progress: 0, challengeId: intervallChallenge.challengeID)
                challenges.append(overview)
            case .failure(let error):
                print(error)
                return []
            }
        }
        
        
        return challenges
    }
}
