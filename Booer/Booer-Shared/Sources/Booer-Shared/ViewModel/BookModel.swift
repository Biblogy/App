//
//  ObservableBook.swift
//  EBookTracking
//
//  Created by Veit Progl on 30.11.20.
//

import Combine
import Foundation
import CoreData

public class BookModel: ObservableObject, BookModelProtocol {
    @Published var item: Book
    @Published var read: String
    
    var context: NSManagedObjectContext
    var challenge: ChallengeModelProtocol?
    
    public init(item: Book, context: NSManagedObjectContext) {
        self.item = item
        self.context = context
        self.read = "\(Int(item.progress))"
    }
    
    public func editItem() {
        item.progress -= 1
        setDone()
    }
    
    public func updateItem(read: Float) -> Bool {
        let progressError = setProgress(read: read)
        setDone()
        
        return progressError
    }
    
    internal func setDone() {
        if item.pages == item.progress {
            item.done = true
            item.doneAt = Date()
        } else {
            item.done = false
            item.doneAt = nil
        }
    }
    
    internal func setProgress(read: Float, date:Date = Date()) -> Bool {
        if read > item.pages {
            return true
        } else {
            item.progress = read
            
            let progress = Progress(context: context)
            progress.date = date
            progress.progress = Int64(read)
            progress.bookid = item.id
            item.addToBookProgress(progress)
            
            return false
        }
    }
    
    public func getChallenge() {
        if item.bookChallenge != nil {
            for item in item.bookChallenge!.allObjects {
                let challenge = item as! Challenges
                
                self.challenge = ChallengeModel(challenge: challenge, context: context)
                self.challenge?.calcStreak()
                self.challenge?.setDone()
                self.challenge?.saveItem()
            }
        }
    }
}
