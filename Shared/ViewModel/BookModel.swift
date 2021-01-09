//
//  ObservableBook.swift
//  EBookTracking
//
//  Created by Veit Progl on 30.11.20.
//

import Combine
import Foundation
import CoreData

class BookModel: ObservableObject {
    @Published var item: Book
    @Published var read: String
    
    var context: NSManagedObjectContext
    
    init(item: Book, context: NSManagedObjectContext) {
        self.item = item
        self.context = context
        self.read = "\(Int(item.progress))"
    }
    
    func editItem() {
        item.progress -= 1
        setDone()
    }
    
    func updateItem(read: Float) -> Bool {
        let progressError = setProgress(read: read)
        setDone()
        
        return progressError
    }
    
    private func setDone() {
        if item.pages == item.progress {
            item.done = true
            item.doneAt = Date()
        } else {
            item.done = false
            item.doneAt = nil
        }
    }
    
    private func setProgress(read: Float) -> Bool {
        if read > item.pages {
            return true
        } else {
            item.progress = read
            
            let progress = Progress(context: context)
            progress.date = Date()
            progress.progress = Int64(read)
            progress.bookid = item.id
            item.addToBookProgress(progress)
            
            return false
        }
    }
}
