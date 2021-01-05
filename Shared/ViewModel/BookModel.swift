//
//  ObservableBook.swift
//  EBookTracking
//
//  Created by Veit Progl on 30.11.20.
//

import Combine
import Foundation

class BookModel: ObservableObject {
    @Published var item: Book
    @Published var read: String
    
    init(item: Book) {
        self.item = item
        self.read = "\(Int(item.progress))"
    }
    
    func editItem() {
        
    }
    
    func updateItem(read: Int) {
        
        
        func setDone() {
            item.done = true
            item.doneAt = Date()
        }
        
        func emptyDone() {
            item.done = false
            item.doneAt = nil
        }
        
        
    }
}
