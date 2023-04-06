//
//  BookProgress.swift
//  
//
//  Created by Veit Progl on 20.03.23.
//

import Foundation

public struct BookProgress {
    let book: Book
    let pages: Int
    let date: Date
    
    public init(book: Book, pages: Int, date: Date) {
        self.book = book
        self.pages = pages
        self.date = date
    }
}
