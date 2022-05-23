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
                    let urlString = title.replacingOccurrences(of: " ", with: "%20")
                    guard let url = URL(string: "http://49.12.191.116/book?title=\(urlString)") else {
                        return .success(.onAppear)
                    }
                    
                    print(url)
                    var messageG: [Book]!
                    let task = URLSession.shared.dataTask(with: url) { data, response, error in
                        if let error = error {
                            print(error)
                            return
                        }
                        if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                            print(response)
                            return
                        }
                        
                        guard let data = data else {
                            print(data)
                            return
                        }
                        
                        do {
                            let decoder = JSONDecoder()
                            var message = try decoder.decode([Book].self, from: data)
                            messageG = message
                            print(message)
                        } catch let err {
                            print(err)
                        }
                    }
                    task.resume()
                    
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
    var pageCount: Int?
    var publisher: String?
    var author: String?
    var subtitle: String?
    
    enum CodingKeys: String, CodingKey {
        case pageCount = "pages"
        case title = "title"
        case subtitle = "subtitle"
   }
}
