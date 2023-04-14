//
//  DatabaseConnect.swift
//  
//
//  Created by Veit Progl on 13.11.22.
//

import Foundation
import DatabaseBooer
import SwiftUI
import BooerKit

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
        
        for field in book.challengeType.type.getFields() {
            switch field.type {
            case .intervallPicker:
                if field.value == "month" {
                    databaseIntervall = .month
                } else if field.value == "year" {
                    databaseIntervall = .year
                } else if field.value == "day" {
                    databaseIntervall = .day
                } else {
                    ErrorHandler.showError(ChallengeError(.valueNotFound))
                }
            case .numberField:
                pages = Int(field.value) ?? 0
            default:
                print("nope error")
                ErrorHandler.showError(ChallengeError(.typeNotFound))
                
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
            ErrorHandler.showError(ChallengeError(.saveFailed))
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
            var endDate: Date?

            switch intervallChallenge.intervall {
            case .month:
                intervall.value = "month"
                if let startDate = intervallChallenge.startDate,
                   let maxBookPages = intervallChallenge.maxBookPages {
                    let neededIntervalls = maxBookPages / intervallChallenge.pages
                    endDate = Calendar.current.date(byAdding: .month, value: neededIntervalls, to: startDate)!
                }
            case .day:
                intervall.value = "day"
                if let startDate = intervallChallenge.startDate,
                   let maxBookPages = intervallChallenge.maxBookPages {
                    let neededIntervalls = maxBookPages / intervallChallenge.pages
                    endDate = Calendar.current.date(byAdding: .day, value: neededIntervalls, to: startDate)!
                }
            case .week:
                intervall.value = "week"
                if let startDate = intervallChallenge.startDate,
                   let maxBookPages = intervallChallenge.maxBookPages {
                    let neededIntervalls = maxBookPages / intervallChallenge.pages
                    endDate = Calendar.current.date(byAdding: .weekOfYear, value: neededIntervalls, to: startDate)!
                }
            case .year:
                intervall.value = "year"
                if let startDate = intervallChallenge.startDate,
                   let maxBookPages = intervallChallenge.maxBookPages {
                    let neededIntervalls = maxBookPages / intervallChallenge.pages
                    endDate = Calendar.current.date(byAdding: .year, value: neededIntervalls, to: startDate)!
                }
            }
                        
            let challengeDescription = "Read \(page.value) Pages every \(intervall.value)"
            
            let bookResult = BiblogyDatabase().books.getBook(id: intervallChallenge.bookID)
            
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
                
                var progress = ProgressState.progress(1)
                if let startDate = intervallChallenge.startDate, let progressDataModel = intervallChallenge.bookProgress, let endDate = endDate {
                    let progressData = progressDataModel.map { progress in
                        return ProgressData(date: progress.date, currentPage: progress.pages, id: UUID().uuidString)
                    }
                    progress = CalcIntervallPage().isFailed(pages: intervallChallenge.pages, intervall: .month, progressData:  progressData, start: startDate, end: endDate, book: book)
                }
                
                let overview = ChallengeOverviewModell(book: book, description: challengeDescription, progress: progress, challengeId: intervallChallenge.challengeID, type: .intervall)
                challenges.append(overview)
            case .failure(let error):
                print(error)
                return []
            }
        }
        
        
        return challenges
    }
}
