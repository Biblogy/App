//
//  BookModel.swift
//  
//
//  Created by Veit Progl on 30.05.22.
//

import Foundation

public struct Book: Decodable, Equatable, Identifiable {
    public var title: String
    public var pageCount: Int
    public var publisher: String? 
    public var author: [String]
    public var subtitle: String
    public let cover: Cover
    public var id = UUID().uuidString
    
    enum CodingKeys: String, CodingKey {
        case pageCount = "pages"
        case title = "title"
        case subtitle = "subtitle"
        case author = "authors"
        case publisher = "publisher"
        case cover = "cover"
    }
    
    public init(from book: BooksDB){
        self.title = book.title ?? ""
        self.pageCount = Int(book.pages)
        self.subtitle = book.subtitle ?? ""
        self.publisher = book.publisher ?? ""
        self.cover = Cover(smallThumbnail: book.coverSmall ?? "", thumbnail: book.coverThumbnail ?? "")
        self.author = []
        book.bookAuthos.map{
            self.author.append($0.name ?? "")
        }
    }
    
    public init(title: String, pageCount: Int = 0, publisher: String = "", author: [String] = [""], subtitle: String = "", cover: Cover = Cover(smallThumbnail: "", thumbnail: "")) {
        self.title = title
        self.pageCount = pageCount
        self.publisher = publisher
        self.author = author
        self.subtitle = subtitle
        self.cover = cover
    }
    
    public init() {
        self.title = "Dummy Book"
        self.pageCount = 0
        self.author = [""]
        self.subtitle = ""
        self.cover = Cover(smallThumbnail: "", thumbnail: "")
        self.id = UUID().uuidString
        self.publisher = ""
    }
}
