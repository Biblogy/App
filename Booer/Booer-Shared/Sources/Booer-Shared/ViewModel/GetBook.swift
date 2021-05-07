//
//  GetBook.swift
//  EBookTracking
//
//  Created by Veit Progl on 30.11.20.
//

import Foundation
import Combine
import Alamofire

public class OpenLibary {
    public init() {}
    
    public func getBooks(bookTitle: String, completion: @escaping (Result<[BookItem], Error>) -> Void) {
        print("=====")
        let url = "https://openlibrary.org/search.json?q=\(bookTitle.replacingOccurrences(of: " ", with: "+"))&mode=everything"
        print(url)
        AF.request(url, method: .get)
            .validate()
            .responseDecodable(of: BooksResponse.self) { (response) in
                switch response.result {
                case .success(let value):
                    completion(.success(value.docs))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
