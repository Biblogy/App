//
//  AddBookCore.swift
//  
//
//  Created Veit Progl on 13.05.22.
//  Copyright © 2022. All rights reserved.
//

import ComposableArchitecture

public enum AddBookCore {}

public extension AddBookCore {
    struct State: Equatable {
        public init() {}
        var bookDetail = BookDetailCore.State()
        var books: [Book] = []
        
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
    }
    
    struct Environment {
        public var fetchBooks: (URL?) -> Effect<[Book], BooksLoaderError>
        public init(fetchBooks: @escaping (URL?) -> Effect<[Book], BooksLoaderError>) {
            self.fetchBooks = fetchBooks
        }
        
        public static var live: Environment = Environment { url in
            guard let url = url else {
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
                guard let url = URL(string: "http://49.12.191.116/book?title=\(urlString)") else {
                    return .none
                }
                
                return environment.fetchBooks(url)
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
            }
        }
    )
}

public struct Book: Decodable, Equatable, Identifiable {
    var title: String
    var pageCount: Int?
    var publisher: String?
    var author: String?
    var subtitle: String?
    public var id = UUID().uuidString
    
    enum CodingKeys: String, CodingKey {
        case pageCount = "pages"
        case title = "title"
        case subtitle = "subtitle"
    }
    
    public init(title: String, pageCount: Int?, publisher: String?, author: String?, subtitle: String?) {
        self.title = title
        self.pageCount = pageCount
        self.publisher = publisher
        self.author = author
        self.subtitle = subtitle
    }
}
