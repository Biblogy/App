//
//  ObservableBook.swift
//  EBookTracking
//
//  Created by Veit Progl on 30.11.20.
//

import Combine

class ObservableBook: ObservableObject {
    @Published var item: Book
    @Published var read: String
    
    init(item: Book) {
        self.item = item
        self.read = "\(Int(item.progress))"
    }
}
