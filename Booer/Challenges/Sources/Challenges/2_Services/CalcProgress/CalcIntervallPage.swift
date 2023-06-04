//
//  CalcIntervallPage.swift
//  
//
//  Created by Veit Progl on 25.03.23.
//

import Foundation
import BooerKit

struct ProgressData {
    let date: Date
    let currentPage: Int
    let id: String
}

enum ProgressState: Equatable {
    case progress(Int)
    case failed
    case success
}

struct CalcIntervallPage {
    private func getIntervallDate(intervall: IntervallTypes, from date: Date) -> Int {
        switch intervall {
        case .day:
            return date.getDay()
        case .month:
            return date.getMonth()
        case .year:
            return date.getYear()
        }
    }
    
    private func datesRange(from: Date, to: Date) -> [Date] {
        // in case of the "from" date is more than "to" date,
        // it should returns an empty array:
        if from > to { return [Date]() }

        var tempDate = from
        var array = [tempDate]

        while tempDate < to {
            tempDate = Calendar.current.date(byAdding: .day, value: 1, to: tempDate)!
            array.append(tempDate)
        }

        return array
    }
    
    func calcDayChallenge(pages: Int, start: Date, end: Date, progressData: [ProgressData], book: Book) -> ProgressState {
        if start < end {
            return .failed
        }
        
        let neededDays = datesRange(from: start, to: end)
        var challengeProgressData: [ProgressData] = []

        progressData.forEach { progress in
            if start <= progress.date && end >= progress.date {
                challengeProgressData.append(progress)
            }
        }
        
        let prozent = (Float(challengeProgressData.count) / Float(neededDays.count)) * 100
        
        if prozent == 100 {
            return .success
        } else if end < Date() {
            return .failed
        }
        
        let readPage = challengeProgressData.max(by: { $0.currentPage < $1.currentPage })
        let progressChanges = self.calcPageChanges(progressData: challengeProgressData)
        if progressChanges.min() ?? pages < pages {
            return ProgressState.failed
        }
        
        if readPage?.currentPage ?? 0 >= book.pages {
            return .progress(Int(prozent))
        }
        
        var i = 0
        for neededDay in neededDays {
            if neededDay == challengeProgressData[i].date {
                i += 1
                continue
            } else {
                return ProgressState.failed
            }
        }
        
        return .progress(Int(prozent))
    }
    
    func isFailed(pages: Int, intervall: IntervallTypes, progressData: [ProgressData], start: Date, end: Date, book: Book) -> ProgressState {
        // 1. Reduce to only months used
        // 2. loop thouse months check if missing one
        // 3. calc progress from month used and max months
        
        // limit to 12 Month!
        // reduce makes no sense for day challenges!
        
        if intervall == .day {
            return calcDayChallenge(pages: pages, start: start, end: end, progressData: progressData, book: book)
        }
        
        let startMonth = getIntervallDate(intervall: intervall, from: start)
        let endMonth = getIntervallDate(intervall: intervall, from: end)
        
        if endMonth < startMonth {
            return .failed
        }
        
        var month: Set<Int> = []
        var challengeProgressData: [ProgressData] = []
        progressData.forEach { progress in
            let progressMonth = getIntervallDate(intervall: intervall, from: progress.date)
            if startMonth <= progressMonth && endMonth >= progressMonth {
                month.insert(progressMonth)
                challengeProgressData.append(progress)
            }
        }
        
        let sortedMonth  = Array(month).sorted()
        let neededMonths = Array(startMonth...endMonth)
        let prozent = (Float(month.count) / Float(neededMonths.count)) * 100
        
        if prozent == 100 {
            return .success
        } else if end > Date() {
            return .failed
        }
        
        let readPage = challengeProgressData.max(by: { $0.currentPage < $1.currentPage })
        
        let progressChanges = self.calcPageChanges(progressData: challengeProgressData)
        if progressChanges.min() ?? pages < pages {
            return ProgressState.failed
        }
        
        if readPage?.currentPage ?? 0 >= book.pages {
            return .progress(Int(prozent))
        }
        
        var i = 0
        for month in sortedMonth {
            if month == neededMonths[i] {
                i += 1
                continue
            } else {
                return ProgressState.failed
            }
        }
        
        return .progress(Int(prozent))
    }
    
    func calcPageChanges(progressData: [ProgressData]) -> [Int] {
        let sortedProgressData = progressData.sorted(by: {$0.date < $1.date})
        var changes: [Int] = []
        var lastPage = 0
        
        sortedProgressData.forEach { progress in
            changes.append(progress.currentPage - lastPage)
            lastPage = progress.currentPage
        }
        return changes
    }
}
