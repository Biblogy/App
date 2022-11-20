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

class Book: BookProtocol {
    let id: String
    let title: String
    let cover: AsyncImage
    let author: [String]
    
    init(id: String, title: String, cover: AsyncImage, author: [String]) {
        self.id = id
        self.title = title
        self.cover = cover
        self.author = author
    }
}
