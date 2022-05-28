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
    
    enum Action: Equatable {
        case onAppear
        case bookDetail(BookDetailCore.Action)
        case requestBook(String)
        case loadedBooks([Book])
    }
    
    struct Environment {
        public init() {}
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
                return Effect.future { promise in
                  let task = URLSession.shared.dataTask(with: url) { data, _, _ in
                      guard let data = data else {
                          promise(.success(.onAppear))
                          return
                      }
                      do {
                          let books = try JSONDecoder().decode([Book].self, from: data)
                          promise(.success(.loadedBooks(books)))
                      } catch {
                          promise(.success(.onAppear))
                      }
                      
                      promise(.success(.onAppear))
                  }
                    task.resume()
                }
            case .bookDetail:
                return .none
            case .loadedBooks(let books):
                state.books = books
                return .none
            }
        }
    )
}

public struct Book: Decodable, Equatable {
    var title: String
    var pageCount: Int?
    var publisher: String?
    var author: String?
    var subtitle: String?
    var id = UUID().uuidString
    
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
