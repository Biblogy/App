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
    func save(challeng: BookChallenge)
}


// aktuell braucht das Package neue Logic um mit der Datenbank arbeiten zu können. Schöner wäre wenn das Package unangerührt bleibe und nur ein Protocoll bereit stellt den die Datenbank folge leisten muss.
class DatabaseConnect: DatabaseConnectProtocol {
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
    
    func save(challeng: BookChallenge) {
        print(challeng)
    }
}
