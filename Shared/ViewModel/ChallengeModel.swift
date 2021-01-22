//
//  ChallengeModel.swift
//  EBookTracking
//
//  Created by Veit Progl on 07.01.21.
//

import Foundation
import Combine
import CoreData

class ChallengeModel {
    
    var challenge: Challenges
    var readDays: Set<Date> = []
    var days: Set<Date> = []
    
    var context: NSManagedObjectContext
        
    init(challenge: Challenges, context: NSManagedObjectContext) {
        self.context = context
        self.challenge = challenge
       
        self.readDays = getReadDays()
        self.days = getDates()
        self.calcStreak()
        self.setDone()
        self.saveItem()
    }
    
    func calcStreak() {
        print("===== \(challenge.challengeBook?.title ?? "ww") ======")
        print("===== \(challenge.time) ======")
        print(Array(readDays).sorted())
        print(Array(days).sorted())
        print(readDays.isSubset(of: days))
        
        if readDays.isSubset(of: days) {
            challenge.isFailed = false
            challenge.streak = Int16(readDays.count - 1)
        } else if readDays.isEmpty {
            challenge.streak = 0
            challenge.isFailed = false
        } else {
            challenge.streak = 0
            challenge.isFailed = true
            challenge.isDone = false
        }
    }
    
    
    func getReadDays() -> Set<Date> {
        var days = challenge.challengeBook!.bookProgress!.map({
            ($0 as! Progress).date!.removeTime()
        })
        days = days.filter { item in
            return item >= challenge.start!.removeTime()
        }
        return Set(days)
    }
    
    func getDates() -> Set<Date> {
        let start = challenge.start!.removeTime()
        let end = Calendar.current.date(byAdding: .day, value: Int(challenge.time), to: challenge.start!)!.removeTime()

        var dates = Set<Date>()
        var check = start

        while check <= end {
            dates.insert(check)
            check = Calendar.current.date(byAdding: .day, value: 1, to: check)!.removeTime()
        }

        return dates
    }
    
    func setDone() {
        if readDays.max() != nil {
            let end = Calendar.current.date(byAdding: .day, value: Int(challenge.time), to: challenge.start!)!
            if readDays.max() == end {
                challenge.isDone = true
            } else if challenge.challengeBook?.done ?? false {
                challenge.isDone = true
            } else {
                challenge.isDone = false
            }
        }
    }
    
    func testDone() {
        let start = challenge.start
        let end = Calendar.current.date(byAdding: .day, value: Int(challenge.time), to: challenge.start!)!

        var dates = Array<Date>()
        var check = start

        while check! <= end {
            dates.append(check!)
            check = Calendar.current.date(byAdding: .day, value: 1, to: check!)!
        }
        
        for time in dates {
            setProgress(read: 1, date: time)
        }
        
        saveItem()
    }
    
    @discardableResult private func setProgress(read: Float, date:Date = Date()) -> Bool {
        if read > challenge.challengeBook!.pages {
            return true
        } else {
            challenge.challengeBook!.progress = read
            
            let progress = Progress(context: context)
            progress.date = date
            progress.progress = Int64(read)
            progress.bookid = challenge.challengeBook!.id
            challenge.challengeBook!.addToBookProgress(progress)
            
            return false
        }
    }
    
    func saveItem() {
        do {
            try context.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}

extension Date {
    func getDay() -> Int {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: self)
        return components.day!
    }
    
    func removeTime() -> Date {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: self)
        return Calendar.current.date(from: components)!
    }
}
