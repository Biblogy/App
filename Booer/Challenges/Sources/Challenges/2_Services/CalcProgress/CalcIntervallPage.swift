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
    func calcProgress(pages: Int, intervall: IntervallTypes, progressData: [ProgressData]) -> Int {
        let currentNewest = progressData.first
//        progressData.forEach { progress in
//            guard let currentDate = currentNewest?.date else { return }
//            if currentDate > progress.date {
//                currentNewest = progress
//            }
//        }
        guard let currentPage =  currentNewest?.currentPage else { return 0 }
        return currentPage
    }
    
    func isFailed(pages: Int, intervall: IntervallTypes, progressData: [ProgressData], start: Date, end: Date, book: Book) -> ProgressState {
        // 1. Reduce to only months used
        // 2. loop thouse months check if missing one
        // 3. calc progress from month used and max months
        let startMonth = start.getMonth()
        let endMonth = end.getMonth()
        
        if endMonth < startMonth {
            return .failed
        }
        
        var month: Set<Int> = []
        var challengeProgressData: [ProgressData] = []
        progressData.forEach { progress in
            let progressMonth = progress.date.getMonth()
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
