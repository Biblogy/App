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
        let allBooks = DatabaseBooer.shared.getAllBooks().map({ book in
            return Book(id: book.id,
                        title: book.title,
                        cover: AsyncImage(url: URL(string: book.cover.thumbnail ?? "") ?? URL(string: "")),
                        author: book.author)
        })
        
        return allBooks
    }
}
