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

public struct AddBookCore: ReducerProtocol {
    public init() {}
    
    public struct State: Equatable {
        public init() {}
        var bookDetail = BookDetailCore.State()
        var books: [Book] = []
        private let bookDB = DatabaseBooer.shared
    }
    
    public enum BooksLoaderError: Error, Equatable {
        case invalidData
        case invalidUrl
        case message(String)
    }
    
    public enum Action: Equatable {
        case onAppear
        case bookDetail(BookDetailCore.Action)
        case requestBook(String)
        case loadedBooks(Result<[Book], BooksLoaderError>)
        case saveBook(Book)
    }
        
    public var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action{
            case .onAppear:
                return .none
            case .requestBook(let title):
                let urlString = title.replacingOccurrences(of: " ", with: "%20")
                
                return getBook(title: urlString)
                    .catchToEffect()
                    .map(Action.loadedBooks)
            case .bookDetail:
                return .none
            case .loadedBooks(.success(let books)):
                state.books = books
                return .none
            case .loadedBooks(.failure(let error)):
                state.books = []
                print(error)
                return .none
            case .saveBook(let book):
                state.saveBook(book: book)
                return .none
            }
        }
    }
}

extension AddBookCore.State {
    func saveBook(book: Book) {
        bookDB.saveBook(book: book)
    }
}

extension AddBookCore {
    private func getBook(title: String) -> Effect<[Book], BooksLoaderError> {
        guard let url = URL(string: "http://49.12.35.64:3000/book?title=\(title)") else {
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
}
