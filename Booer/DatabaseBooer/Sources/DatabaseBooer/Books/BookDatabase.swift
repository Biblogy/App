//
//  BookDatabase.swift
//  
//
//  Created by Veit Progl on 19.02.23.
//

import Foundation
import CoreData

public protocol BookDatabaseProtrocol {
    func updateBook(book: Book)
    func saveBook(book: Book)
    func getAllBooks() -> [Book]
    func deleteBook(book: Book)
    func getBook(id: String) -> Result<BooksDB, BooksError>
    func getBookTitle(id: String) -> Result<String, BooksError>
}


struct BookDatabaseProviderKey: InjectionKey {
    static var currentValue: BookDatabaseProtrocol = BookDatabase()
}

extension InjectedValues {
    var bookDatabase: BookDatabaseProtrocol {
        get { Self[BookDatabaseProviderKey.self] }
        set { Self[BookDatabaseProviderKey.self] = newValue }
    }
}

struct BookDatabase: BookDatabaseProtrocol {
    var viewContext = PersistenceController.shared.container.viewContext

    public func updateBook(book: Book) {
        let predicate = NSPredicate(format: "id == %@", book.id)
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "BooksDB")
        fetch.predicate = predicate
        
        do {
            let bookObject = try viewContext.fetch(fetch)
            let first = bookObject.first as? BooksDB
            first?.title = book.title
            first?.pages = Int16(book.pageCount)
        } catch {
            print("fetch failed")
        }
        
        do {
            try viewContext.save()
        } catch {
            print("error")
        }
    }
    
    public func saveBook(book: Book) {
        let newBook = BooksDB(context: viewContext)
        newBook.id = book.id
        newBook.title = book.title
        newBook.pages = Int16(book.pageCount )
        newBook.subtitle = book.subtitle
        newBook.coverSmall = book.cover.smallThumbnail
        newBook.coverThumbnail = book.cover.thumbnail
        
        do {
            try viewContext.save()
        } catch {
            print("error")
        }
    }
    
    public func getAllBooks() -> [Book] {
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
    
    public func deleteBook(book: Book) {
        let predicate = NSPredicate(format: "id == %@", book.id)
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "BooksDB")
        fetch.predicate = predicate
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetch)
        
        do {
            try viewContext.execute(deleteRequest)
        } catch let error as NSError {
            // TODO: handle the error
            print(error.localizedDescription)
        }
    }
    
    func getBook(id: String) -> Result<BooksDB, BooksError> {
        let predicate = NSPredicate(format: "id == %@", id)
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "BooksDB")
        fetch.predicate = predicate
        
        do {
            let objects = try viewContext.fetch(fetch)
            let book = objects.first
            if let book = book as? BooksDB {
                return .success(book)
            }
            
        } catch let error {
            print(error)
            return .failure(.BookIdNotFound)
        }
        return .failure(.BookIdNotFound)
    }
    
    func getBookTitle(id: String) -> Result<String, BooksError> {
        let bookResult = self.getBook(id: id)
        
        switch bookResult {
        case let .success(book):
            guard let title = book.title else {
                return .failure(.TitleNotFound)
            }
            
            return .success(title)
        case let .failure(error):
            return .failure(error)
        }
    }
    
}
