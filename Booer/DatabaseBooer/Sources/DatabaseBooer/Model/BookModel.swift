//
//  BookModel.swift
//  
//
//  Created by Veit Progl on 30.05.22.
//

import Foundation

public struct Book: Decodable, Equatable, Identifiable, Hashable {
    public var title: String
    public var pageCount: Int?
    public var publisher: String?
    public var author: [String]?
    public var subtitle: String?
    public let cover: Cover?
    public var id = UUID().uuidString
    
    enum CodingKeys: String, CodingKey {
        case pageCount = "pages"
        case title = "title"
        case subtitle = "subtitle"
        case author = "authors"
        case publisher = "publisher"
        case cover = "cover"
    }
    
    public init(from: BooksDB){
        self.title = from.title ?? ""
        self.pageCount = Int(from.pages)
        self.subtitle = from.subtitle
        self.publisher = from.publisher
        self.cover = Cover(smallThumbnail: from.coverSmall ?? "", thumbnail: from.coverThumbnail ?? "")
        self.author = []
        from.bookAuthos.map{
            self.author?.append($0.name ?? "")
        }
    }
    
    public init(title: String, pageCount: Int?, publisher: String?, author: [String]?, subtitle: String?, cover: Cover?) {
        self.title = title
        self.pageCount = pageCount
        self.publisher = publisher
        self.author = author
        self.subtitle = subtitle
        self.cover = cover
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
