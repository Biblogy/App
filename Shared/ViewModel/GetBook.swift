//
//  GetBook.swift
//  EBookTracking
//
//  Created by Veit Progl on 30.11.20.
//

import Foundation
import Combine
import Alamofire

func getBooks(bookTitle: String, completion: @escaping (Result<[BookItem], Error>) -> Void) {
    print("=====")
    let url = "https://openlibrary.org/search.json?title=\(bookTitle)"
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
