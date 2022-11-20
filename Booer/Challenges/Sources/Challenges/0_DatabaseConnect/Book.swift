//
//  File.swift
//  
//
//  Created by Veit Progl on 14.11.22.
//

import Foundation
import SwiftUI

protocol BookProtocol {

}

public class Book: BookProtocol, Equatable, Identifiable {
    public static func == (lhs: Book, rhs: Book) -> Bool {
        return lhs.id == rhs.id
    }
    
    public let id: String
    let title: String
    let cover: URL
    let author: [String]
    
    init(id: String, title: String, cover: URL, author: [String]) {
        self.id = id
        self.title = title
        self.cover = cover
        self.author = author
    }
}
