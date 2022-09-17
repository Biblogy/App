//
//  AddBookCore.swift
//  
//
//  Created Veit Progl on 13.05.22.
//  Copyright © 2022. All rights reserved.
//

import ComposableArchitecture
import DatabaseBooer
import Foundation

public enum AddBookCore {}

public extension AddBookCore {
    struct State: Equatable {
        public init() {}
        var bookDetail = BookDetailCore.State()
        var books: [Book] = []
        private let bookDB = DatabaseBooer.shared
    }
    
    enum BooksLoaderError: Error, Equatable {
        case invalidData
        case invalidUrl
        case message(String)
    }
    
    enum Action: Equatable {
        case onAppear
        case bookDetail(BookDetailCore.Action)
        case requestBook(String)
        case loadedBooks(Result<[Book], BooksLoaderError>)
        case saveBook(Book)
    }
    
    struct Environment {
        public var fetchBooks: (String?) -> Effect<[Book], BooksLoaderError>
        public init(fetchBooks: @escaping (String?) -> Effect<[Book], BooksLoaderError>) {
            self.fetchBooks = fetchBooks
        }
        
        public static var live: Environment = Environment { title in
            guard let url = URL(string: "http://49.12.35.64:3000/book?title=\(title ?? "")") else {
                return Effect(error: BooksLoaderError.invalidUrl)
            }
            
            return URLSession.shared.dataTaskPublisher(for: url)
                .receive(on: RunLoop.main)
                .map(\.data)
                .tryMap({ data -> [Book] in
                    do {
                        let books = try JSONDecoder().decode([Book].self, from: data)
                        return books
                    } catch {
                        throw BooksLoaderError.invalidData
                    }
                })
                .mapError({ BooksLoaderError.message($0.localizedDescription) })
                .eraseToEffect()
        }
        
        public static var dev: Environment = Environment { title in
            guard let url = URL(string: "http://localhost:3000/book?title=\(title ?? "")") else {
                return Effect(error: BooksLoaderError.invalidUrl)
            }
            return URLSession.shared.dataTaskPublisher(for: url)
                .receive(on: RunLoop.main)
                .map(\.data)
                .tryMap({ data -> [Book] in
                    do {
                        let books = try JSONDecoder().decode([Book].self, from: data)
                        return books
                    } catch {
                        throw BooksLoaderError.invalidData
                    }
                })
                .mapError({ BooksLoaderError.message($0.localizedDescription) })
                .eraseToEffect()
        }
        
        public static var mock: Environment = Environment { url in
            guard let url = url else {
                return Effect(error: BooksLoaderError.invalidData)
            }
            return Effect(value: [])
        }
    }
    
    static let reducer = Reducer<State, Action, Environment>.combine(
        .init { state, action, environment in
            switch action{
            case .onAppear:
                return .none
            case .requestBook(let title):
                let urlString = title.replacingOccurrences(of: " ", with: "%20")
                
                return environment.fetchBooks(urlString)
                    .catchToEffect()
                    .map(Action.loadedBooks)
            case .bookDetail:
                return .none
            case .loadedBooks(.success(let books)):
                state.books = books
                return .none
            case .loadedBooks(.failure(let error)):
                state.books = []
                return .none
            case .saveBook(let book):
                state.saveBook(book: book)
                return .none
            }
        }
    )
}

extension AddBookCore.State {
    func saveBook(book: Book) {
        bookDB.saveBook(book: book)
    }
}
