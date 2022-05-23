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
        
    }
    
    enum Action: Equatable {
        case onAppear
        case bookDetail(BookDetailCore.Action)
        case requestBook(String)
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
                return .result {
                    guard let url = URL(string: "http://49.12.191.116/book?title=\(title)") else {
                        return .success(.onAppear)
                    }
                    
                    let task = URLSession.shared.dataTask(with: url) { data, response, error in
                        if let error = error {
                            return
                        }
                        if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                            return
                        }
                        
                        guard let data = data else {
                            return
                        }
                        
                        do {
                            let decoder = JSONDecoder()
                            let message = try decoder.decode(Book.self, from: data)
                        }
                        catch {
                            
                        }
                    }
                    return .success(.onAppear)
                }
            case .bookDetail:
                return .none
            }
        }
    )
}

struct Book: Decodable {
    var title: String
    var pageCount: String
    var publisher: String
    var author: String
}

let loadBooksEffect = {
    Effect<Book, Error>.result {
        let fileUrl = URL(
            fileURLWithPath: NSSearchPathForDirectoriesInDomains(
                .documentDirectory, .userDomainMask, true
            )[0]
        )
            .appendingPathComponent("user.json")
        
        let result = Result<Book, Error> {
            let data = try Data(contentsOf: fileUrl)
            return try JSONDecoder().decode(Book.self, from: data)
        }
        
        return result
    }
}
