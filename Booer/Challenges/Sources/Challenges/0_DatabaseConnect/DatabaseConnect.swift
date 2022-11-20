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
    func getAllBooks()
}

class DatabaseConnect {
    func getAllBooks() -> [Book] {
        let allBooks = DatabaseBooer.shared.getAllBooks().map { book -> Book in
            let coverUrl = URL(string: book.cover.thumbnail ?? "") ?? URL(string: "")
            
            return Book(id: book.id,
                        title: book.title,
                        cover: coverUrl!,
                        author: book.author)
        }
        
        return allBooks
    }
}
