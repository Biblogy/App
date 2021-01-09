//
//  ChallengeModel.swift
//  EBookTracking
//
//  Created by Veit Progl on 07.01.21.
//

import Foundation
import Combine

class ChallengeModel: ObservableObject {
    
    var challenge: Challenges
    var readDays: Set<Int> = []
    var days: Set<Int> = []
    
    @Published var streak = 0
    
    init(challenge: Challenges) {
        self.challenge = challenge
        self.readDays = getReadDays()
        self.days = getDates()
        self.calcStreak()
        self.setDone()
    }
    
    func calcStreak() {
        if readDays == days {
            challenge.isFailed = false
            streak = readDays.count
        } else if readDays.isEmpty {
            streak = 0
            challenge.isFailed = false
        } else {
            streak = 0
            challenge.isFailed = true
            challenge.isDone = false
        }
    }
    
    
    func getReadDays() -> Set<Int> {
        var days = challenge.challengeBook!.bookProgress!.map({
                ($0 as! Progress).date!.getDay()
        })
        days = days.filter { item in
            return item >= challenge.start!.getDay()
        }
        return Set(days)
    }
    
    func getDates() -> Set<Int> {
        let start = challenge.start
        let end = Date().getDay()

        var dates = Set<Int>()
        var check = start

        while check!.getDay() <= end {
            dates.insert(check!.getDay())
            check = Calendar.current.date(byAdding: .day, value: 1, to: check!)!
        }

        return dates
    }
    
    func setDone() {
        if readDays.max() != nil {
            let end = Calendar.current.date(byAdding: .day, value: Int(challenge.time), to: challenge.start!)!
            if readDays.max() == end.getDay() {
                challenge.isDone = true
            } else if challenge.challengeBook?.done ?? false {
                challenge.isDone = true
            } else {
                challenge.isDone = false
            }
        }
    }
}

extension Date {
    func getDay() -> Int {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: self)
        return components.day!
    }
}
