//
//  BookManagmentDatabase.swift
//  BookManagment
//
//  Created by Veit Progl on 18.03.23.
//

import Foundation
import DatabaseBooer

public struct BookProgressModel {
    let book: Book
    let pages: Int
    let date: Date
    
    public init(book: Book, pages: Int, date: Date) {
        self.book = book
        self.pages = pages
        self.date = date
    }
}

public protocol BookManagmentDatabaseProtocol {
    func setBookProgress(progress: BookProgressModel) -> Result<Void, Error>
}


public struct BookManagmentDatabase: BookManagmentDatabaseProtocol {
    func setBookProgress(progress: BookProgressModel) -> Result<Void, Error> {
        let progressDB = BookProgress(book: progress.book, pages: progress.pages, date: progress.date)
        return BiblogyDatabase().books.setBookProgress(progress: progressDB)
    }
}
